#!/usr/bin/env bash

set -euo pipefail

main () {

luhn_valid() {
    local input="$1"
    # remove spaces
    local sanitized="${input//[[:space:]]/}"
    # check length > 1
    if [ "${#sanitized}" -le 1 ]; then
        return 1
    fi
    # only digits allowed
    if [[ ! $sanitized =~ ^[0-9]+$ ]]; then
        return 1
    fi

    local sum=0
    local digit
    local double=false

    # process digits from right to left
    for (( i=${#sanitized}-1; i>=0; i-- )); do
        digit="${sanitized:$i:1}"
        if $double; then
            # double it
            local v=$(( digit * 2 ))
            if [ $v -gt 9 ]; then
                v=$(( v - 9 ))
            fi
            sum=$(( sum + v ))
        else
            sum=$(( sum + digit ))
        fi
        # flip double for next iteration
        if $double; then
            double=false
        else
            double=true
        fi
    done

    # valid if sum divisible by 10
    if (( sum % 10 == 0 )); then
        return 0
    else
        return 1
    fi
}

# small driver if called with an argument
if [[ ${BASH_SOURCE[0]} == "${0}" ]]; then
    if luhn_valid "$1"; then
        echo "true"
    else
        echo "false"
    fi
fi

}

main "$@"
