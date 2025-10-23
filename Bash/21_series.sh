#!/usr/bin/env bash

main () {
    number=${1:-}
    number_length=${#number}
    length=${2:-}
    if (( number_length == 0 )); then
        echo "series cannot be empty" >&2
        exit 1
    fi
    if (( length > number_length )); then
        echo "slice length cannot be greater than series length" >&2
        exit 1
    fi
    if (( length == 0 )); then
        echo "slice length cannot be zero" >&2
        exit 1
    fi
    if (( length < 0 )); then
        echo "slice length cannot be negative" >&2
        exit 1
    fi
    for (( i=0; i<=( number_length - length ); i++  )); do
        if (( i > 0 )); then
            echo -n " "
        fi
        echo -n ${number:i:length}
    done
}

main "$@"
