#!/usr/bin/env bash

set -euo pipefail

die() {
    printf "%s\n" "$1"
    exit 1
}

main() {
    inbase=$1
    digits=$2
    outbase=$3

    # ----- base validation -----
    (( inbase > 1 ))  || die "invalid input base"
    (( outbase > 1 )) || die "invalid output base"

    # ----- empty digits → output 0 -----
    if [[ -z $digits ]]; then
        printf "0\n"
        exit 0
    fi

    # split input digits into array
    read -r -a arr <<< "$digits"

    # validate digits
    for d in "${arr[@]}"; do
        (( d >= 0 ))      || die "invalid digit"
        (( d < inbase ))  || die "invalid digit"
    done

    # ----- convert to decimal -----
    value=0
    for d in "${arr[@]}"; do
        value=$(( value * inbase + d ))
    done

    # special case 0
    if (( value == 0 )); then
        printf "0\n"
        exit 0
    fi

    # ----- convert from decimal to output base -----
    out=()
    while (( value > 0 )); do
        rem=$(( value % outbase ))
        out=( "$rem" "${out[@]}" )
        value=$(( value / outbase ))
    done

    printf "%s\n" "${out[*]}"
}

main "$@"
