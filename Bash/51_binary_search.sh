#!/usr/bin/env bash

main () {
    set -euo pipefail

    target="$1"
    shift             # remaining arguments = array elements
    arr=("$@")        # store array

    left=0
    right=$(( ${#arr[@]} - 1 ))

    # Binary search
    while (( left <= right )); do
        mid=$(( (left + right) / 2 ))
        val=${arr[mid]}

        if (( val == target )); then
            echo "$mid"
            exit 0
        elif (( val < target )); then
            left=$(( mid + 1 ))
        else
            right=$(( mid - 1 ))
        fi
    done

    # Not found
    echo -1

}

main "$@"
