#!/usr/bin/env bash
set -euo pipefail

main() {
    local num=${1:-0}
    (( num < 0 )) && exit 1

    local -a values=(1000 900 500 400 100 90 50 40 10 9 5 4 1)
    local -a numerals=(M CM D CD C XC L XL X IX V IV I)

    local result=""

    for i in "${!values[@]}"; do
        while [ "$num" -ge "${values[i]}" ]; do
            result+="${numerals[i]}"
            num=$(( num - values[i] ))
        done
    done

    echo "$result"
}

main "$@"
