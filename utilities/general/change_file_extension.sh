#!/usr/bin/bash

# File:         change_file_extension.sh
# Author:       Franklyn Dahlberg
# Created:      12 November, 2025
# Copyright:    2025 (c) Franklyn Dahlberg
# License:      MIT License (see https://choosealicense.com/licenses/mit/)
# Description:  Modifies all the files found at the param input directory with
#               the param 'from_file_extension' to have the 'to_file_extension'

INPUT_DIR=""
FROM_EXT=""
TO_EXT=""
INPUT_FILES=""

function check_params() {
    if [ "$#" -ne 3 ]; then
        echo "Incorrect number of arguments passed to script."
        echo "Correct usage is:"
        echo "  change_file_extension.sh <directory> <from_file_extension> <to_file_extension>"
        echo "Exiting."
        exit -1
    fi

    INPUT_DIR=$1
    FROM_EXT=$2
    TO_EXT=$3
}

function get_input_files() {
    readarray -d '' INPUT_FILES < <(find "$INPUT_DIR" -maxdepth 1 -name "*\.$FROM_EXT" -print0)
    
    if [ "${#INPUT_FILES[@]}" -eq 0 ]; then
        echo "No files with extension $FROM_EXT found in $INPUT_DIR."
        echo "Exiting."
        exit -1
    fi
}

function user_confirm() {
    echo "Converting the ${#INPUT_FILES[@]} '$FROM_EXT' files found in: $INPUT_DIR to '$TO_EXT'."
    echo "Press 'y' to confirm, press any other key to cancel:"
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
    REGEX="s/\.$FROM_EXT/\.$TO_EXT/g"
    END_FILE=$(echo "$START_FILE" | sed --expression="$REGEX")

    mv "$START_FILE" "$END_FILE"

    if [ "$?" -ne 0 ]; then
        echo "A problem occured when converting $START_FILE"
        echo "Exiting."
        exit -1
    fi
}

function main() {
    check_params "$@"
    get_input_files
    user_confirm

    for FILE in "${INPUT_FILES[@]}"
    do
        convert_file $FILE
    done

    echo "Done!"
    echo ""
}

main "$@"
