#!/usr/bin/env bash

main () {
    number=${1:-}
    counter=0
    if ! (( number > 0 )); then
        echo "Error: Only positive numbers are allowed"
        exit 1
    fi
    while ! ((number == 1)); do
        while ((number % 2 == 0)); do
            ((number /= 2))
            ((counter += 1))
            if ((number == 1)); then
                echo $counter
                exit 0
            fi
        done
        while (( number % 2 == 1 )); do
            ((number *= 3))
            ((number += 1))
            ((counter += 1))
        done
    done
    echo $counter
}

main "$@"
