#!/usr/bin/bash

# File:         flac_to_mp3.sh
# Author:       Franklyn Dahlberg
# Created:      9 November, 2025
# Copyright:    2025 (c) Franklyn Dahlberg
# License:      MIT License (see https://choosealicense.com/licenses/mit/)
# Description:  Converts audio files from the param directory from FLAC
#               to MP3, placing the new files in the second param directory

INPUT_DIR=""
OUTPUT_DIR=""
INPUT_FILES=""

function check_params() {
    if [ "$#" -ne 2 ]; then
        echo "Incorrect number of arguments passed to script."
        echo "Correct usage is:"
        echo "  flac_to_mp3.sh <input_dir> <output_dir>"
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
    OUTPUT_DIR="$2"

    if [ ! -d "$OUTPUT_DIR" ]; then
        mkdir -p $OUTPUT_DIR
        if [ $? -ne 0 ]; then
            echo "Failed to create output directory $OUTPUT_DIR"
            echo "Exiting."
            exit -1
        fi
    fi
}

function get_input_files() {
    readarray -d '' INPUT_FILES < <(find "$INPUT_DIR" -maxdepth 1 -name '*flac' -print0)
    
    if [ "${#INPUT_FILES[@]}" -eq 0 ]; then
        echo "Could not find any FLAC files in $INPUT_DIR"
        echo "Exiting."
        exit -1
    fi
}

function user_confirm() {
    echo "Converting the ${#INPUT_FILES[@]} 'flac' files found in: $INPUT_DIR" 
    echo "to 'mp3', and placing them in: $OUTPUT_DIR"
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
    START_BASE=$(basename "$START_FILE")

    END_FILE=$(echo "$START_BASE" | sed --expression='s/\.flac/\.mp3/g')
    END_FILE="$OUTPUT_DIR/$END_FILE"

    echo "Converting $START_FILE to $END_FILE"

    ffmpeg -hide_banner -loglevel error -i "$START_FILE" "$END_FILE"

    if [ "$?" -ne 0 ]; then
        echo "A problem occured when converting $START_FILE"
        echo "Exiting."
        exit -1
    fi
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
