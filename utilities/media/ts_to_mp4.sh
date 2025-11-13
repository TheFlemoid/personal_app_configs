#!/usr/bin/bash

# File:         ts_to_mp4.sh
# Author:       Franklyn Dahlberg
# Created:      11 November, 2025
# Copyright:    2025 (c) Franklyn Dahlberg
# License:      MIT License (see https://choosealicense.com/licenses/mit/)
# Description:  Converts video files from the param directory from MPEG-TS (ts)
#               to MP4, replacing the old files with the new ones.

INPUT_DIR=""
INPUT_FILES=""

function check_params() {
    if [ "$#" -ne 1 ]; then
        echo "Incorrect number of arguments passed to script."
        echo "Correct usage is:"
        echo "  ts_to_mp4.sh <input_dir>"
        echo "Exiting."
        exit -1        
    fi

    if [ ! -d "$1" ]; then
        echo "Couldn't find input directory: $1"
        echo "Exiting."
        exit -1
    fi

    which ffmpeg > /dev/null
    if [ $? -ne 0 ]; then
        echo "Could not find ffmpeg on this host."
        echo "This tool requires ffmpeg to convert audio files."
        echo "Please install it and run this again."
        exit -1
    fi
    
    INPUT_DIR="$1"
}

function get_input_files() {
    readarray -d '' INPUT_FILES < <(find "$INPUT_DIR" -maxdepth 1 -name '*\.ts' -print0)
    
    if [ "${#INPUT_FILES[@]}" -eq 0 ]; then
        echo "Could not find any MPEG-TS files in $INPUT_DIR"
        echo "Exiting."
        exit -1
    fi
}

function user_confirm() {
    echo "Converting the ${#INPUT_FILES[@]} MPEG-TS files found in: $INPUT_DIR to 'mp4'."
    echo ""
    echo "Press y to confirm, press any other key to cancel: "
    read -n1 USER_CONFIRM
    echo ""

    if [ "$USER_CONFIRM" = "y" ]; then
        echo "Ok"
    else
        echo "Cancelling"
        exit 0
    fi
}

function convert_file() {
    START_FILE="$1"
    END_FILE=$(echo "$START_FILE" | sed --expression='s/\.ts/\.mp4/g')

    echo "Converting $START_FILE to $END_FILE"

    ffmpeg -hide_banner -i "$START_FILE" -c:v copy -c:a copy "$END_FILE"

    if [ "$?" -ne 0 ]; then
        echo "A problem occured when converting $START_FILE"
        echo "Exiting."
        exit -1
    fi

    rm -f $START_FILE
    echo ""
    echo ""
}

function main() {
    echo ""

    check_params "$@"
    get_input_files
    user_confirm

    for FILE in "${INPUT_FILES[@]}"
    do
        convert_file "$FILE"
    done

    echo "Done!"
    echo ""
}

main "$@"
