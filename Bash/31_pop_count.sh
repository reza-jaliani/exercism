#!/usr/bin/env bash

main() {
    input=$1
    binary_input=$(echo "obase=2;$input" | bc)
    length=${#binary_input}
    counter=0
    for (( i=length; i>=0; i-- )); do
        power=$((length - 1))
        if ! (( input < (2 ** i) )); then
            (( counter += 1 ))
            (( input -= (2 ** i) ))
        fi
    done
    echo "$counter"
}

main "$@"
