#!/usr/bin/env bash

main() {
    square=${1:-}

    if [[ -z $square ]]; then
        echo "Error: invalid input" >&2
        exit 1
    fi

    if [[ "$square" == "total" ]]; then
        grains=0
        for (( i=1; i<=64; i++ )); do
            squareGrains=$(echo "2 ^ ($i - 1)" | bc)
            grains=$(echo "$grains + $squareGrains" | bc)
        done
    else
        if (( square < 1 || square > 64 )); then
            echo "Error: invalid input" >&2
            exit 1
        fi
        grains=$(echo "2 ^ ($square - 1)" | bc)
    fi

    echo "$grains"
}

main "$@"
