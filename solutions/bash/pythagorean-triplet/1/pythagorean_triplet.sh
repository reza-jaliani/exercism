#!/usr/bin/env bash

main () {
    N="$1"

# validate numeric input
    [[ "$N" =~ ^[0-9]+$ ]] || exit 0

# loop only while a < b < c and a + b + c = N
    for ((a = 1; a < N/3; a++)); do
        for ((b = a+1; b < N/2; b++)); do
            c=$((N - a - b))
            # enforce a < b < c
            ((b < c)) || continue
            # check pythagorean
            if (( a*a + b*b == c*c )); then
              echo "$a,$b,$c"
            fi
        done
    done
}

main "$@"