#!/usr/bin/env bash

main () {
    number=${1:-}
    if [[ -z "$number" || "$number" -le 1 ]]; then
        echo ""
        exit 0
    fi
    factors=()
    while (( number % 2 == 0 )); do
        factors+=("2")
        (( number /= 2 ))
    done
    divisor=3
    while (( divisor * divisor <= number )); do
        while (( number % divisor == 0 )); do
            factors+=("$divisor")
            (( number /= divisor ))
        done
        (( divisor += 2 ))
    done
    if (( number > 2 )); then
        factors+=("$number")
    fi
    echo "${factors[@]}"
}

main "$@"
