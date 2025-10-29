#!/usr/bin/env bash

main () {
    x=$1
    y=$2
    if ! [[ $x =~ ^-?[0-9]*\.?[0-9]+$ && $y =~ ^-?[0-9]*\.?[0-9]+$ ]]; then
        echo "invalid input"
        exit 1
    fi
    distance=$(echo "scale=6; sqrt(($x * $x) + ($y * $y))" | bc -l)
    if (( $(echo "$distance <= 1" | bc -l) )); then
        echo 10
    elif (( $(echo "$distance <= 5" | bc -l) )); then
        echo 5
    elif (( $(echo "$distance <= 10" | bc -l) )); then
        echo 1
    else
        echo 0
    fi
}

main "$@"
