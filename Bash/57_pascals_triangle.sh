#!/usr/bin/env bash
set -euo pipefail

main() {
    local rows=${1:-0}
    declare -A triangle

    (( rows <= 0 )) && exit 0

    # Build the triangle
    for ((i=0; i<rows; i++)); do
        for ((j=0; j<=i; j++)); do
            if (( j == 0 || j == i )); then
                triangle["$i,$j"]=1
            else
                left=${triangle["$((i-1)),$((j-1))"]}
                right=${triangle["$((i-1)),$j"]}
                triangle["$i,$j"]=$((left + right))
            fi
        done
    done

    # Now print it centered the way Exercism wants
    # Top row has (rows - 1) leading spaces
    for ((i=0; i<rows; i++)); do
        # Leading spaces
        printf "%*s" $((rows - i - 1)) ""

        # Row contents
        for ((j=0; j<=i; j++)); do
            printf "%s" "${triangle["$i,$j"]}"
            (( j < i )) && printf " "
        done
        printf "\n"
    done
}

main "$@"
