#!/usr/bin/env bash

main() {
    name=$1
    number=$2

    last_two=$(( number % 100 ))
    last_digit=$(( number % 10 ))

    if (( last_two == 11 || last_two == 12 || last_two == 13 )); then
        suffix="th"
    elif (( last_digit == 1 )); then
        suffix="st"
    elif (( last_digit == 2 )); then
        suffix="nd"
    elif (( last_digit == 3 )); then
        suffix="rd"
    else
        suffix="th"
    fi

    echo "$name, you are the ${number}${suffix} customer we serve today. Thank you!"
}

main "$@"
