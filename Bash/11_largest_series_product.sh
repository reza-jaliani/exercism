#!/usr/bin/env bash

main() {
    local input=$1
    local span=$2
    if [[ -z $input || -z $span ]]; then
        echo "span must not exceed string length" >&2
        exit 1
    fi
    if [[ ! $input =~ ^[0-9]+$ ]]; then
        echo "input must only contain digits" >&2
        exit 1
    fi
    if (( span < 0 )); then
        echo "span must not be negative" >&2
        exit 1
    fi
    if (( span > ${#input} )); then
        echo "span must not exceed string length" >&2
        exit 1
    fi
    if (( span == 0 )); then
        echo 1
        exit 0
    fi
    local max=0
    for ((i = 0; i <= ${#input} - span; i++)); do
        local series=${input:i:span}
        local product=1
        for ((j = 0; j < span; j++)); do
            digit=${series:j:1}
            (( product *= digit ))
        done
        (( product > max )) && max=$product
    done
    echo "$max"
}
main "$@"
