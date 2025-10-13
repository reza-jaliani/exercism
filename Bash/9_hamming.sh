#!/usr/bin/env bash
main() {
    if (( $# < 2 )); then
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
    fi
    DNA1=$1
    DNA2=$2
    lengthDNA1=${#DNA1}
    lengthDNA2=${#DNA2}
    countDistance=0
    if (( lengthDNA1 != lengthDNA2 )); then
        echo "strands must be of equal length"
        exit 1
    fi
    if (( lengthDNA1 == 0 )); then
        echo 0
        exit 0
    fi

    for (( i=0; i<lengthDNA1; i++ )); do
        if [[ "${DNA1:$i:1}" != "${DNA2:$i:1}" ]]; then
            ((countDistance++))
        fi
    done
    echo "$countDistance"
}
main "$@"
