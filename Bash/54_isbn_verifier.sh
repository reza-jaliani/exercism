#!/usr/bin/env bash

main() {
    isbn="$1"

    # Remove hyphens
    clean="${isbn//-/}"

    # Must be 10 characters
    [[ ${#clean} -ne 10 ]] && { echo false; return; }

    # First 9 must be digits
    for ((i=0; i<9; i++)); do
        [[ ${clean:i:1} =~ [0-9] ]] || { echo false; return; }
    done

    # Last char must be digit or X
    last="${clean:9:1}"
    if [[ $last =~ [0-9] ]]; then
        value=$last
    elif [[ $last == "X" ]]; then
        value=10
    else
        echo false
        return
    fi

    # Compute checksum
    sum=0
    weight=10

    for ((i=0; i<9; i++)); do
        digit=${clean:i:1}
        sum=$((sum + digit * weight))
        weight=$((weight - 1))
    done

    # Add final digit (weight 1)
    sum=$((sum + value * 1))

    # Valid if divisible by 11
    if (( sum % 11 == 0 )); then
        echo true
    else
        echo false
    fi
}

main "$@"
