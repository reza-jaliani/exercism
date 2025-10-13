#!/usr/bin/env bash
main () {
    command=${1:-}
    input=${2:-0}
    squareOfSum=0
    sumOfSquare=0
    diff=0
    for (( i=1; i<=input; i++ )); do
        squareOfSum=$(( squareOfSum + i ))
        sumOfSquare=$(( sumOfSquare + ( i*i ) ))
    done
    squareOfSum=$(( squareOfSum * squareOfSum ))
    if [[ "$command" == "sum_of_squares" ]]; then
        diff="$sumOfSquare"
    elif [[ "$command" == "square_of_sum" ]]; then
        diff="$squareOfSum"
    elif [[ "$command" == "difference" ]]; then
        diff="$((squareOfSum - sumOfSquare))"
    else
        echo "Something is wrong!"
    fi
    echo $diff
}
main "$@"
