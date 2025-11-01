#!/usr/bin/env bash

main() {
    limit=$1
    shift                     # remove the first arg (the limit)
    bases=("$@")              # remaining args are base values
    declare -A seen           # associative array to avoid duplicates
    sum=0

    # Loop through each base value
    for base in "${bases[@]}"; do
        # skip invalid or zero bases
        (( base == 0 )) && continue

        # loop through multiples of base less than limit
        for (( i=base; i<limit; i+=base )); do
            # only count each number once
            if [[ -z "${seen[$i]}" ]]; then
                seen[$i]=1
                (( sum += i ))
            fi
        done
    done

    echo "$sum"
}

main "$@"
