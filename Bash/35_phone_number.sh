#!/usr/bin/env bash

main() {
    input=${1:-}
    tel_number=$(echo "$input" | sed 's/[+(). -]//g')
    length=${#tel_number}
    if (( length < 10 || length > 11 )); then
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    fi
    if (( length == 11 )); then
        if [[ ! $tel_number =~ ^1 ]]; then
            echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
            exit 1
        else
            tel_number=${tel_number#1}
        fi
    fi
    if [[ ! $tel_number =~ ^[2-9][0-9]{2}[2-9][0-9]{6}$ ]]; then
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    fi
    echo "$tel_number"
}

main "$@"
