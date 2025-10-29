#!/usr/bin/env bash

main () {
    word=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alpha:]')
    length=${#word}
    isogram="true"
    for (( i=0; i<length; i++ )); do
        char=${word:i:1}
        for (( j=i+1; j<length; j++ )); do
            if [[ $char == ${word:j:1} ]]; then
                isogram="false"
                break 2
            fi
        done
    done
    echo "$isogram"
}

main "$@"
