#!/usr/bin/env bash

main () {
    input=${1:-}
    sound=false
    if (( input % 3 == 0 )); then
        echo -n "Pling"
        sound=true
    fi
    if (( input % 5 == 0 )); then
        echo -n "Plang"
        sound=true
    fi
    if (( input % 7 == 0 )); then
        echo -n "Plong"
        sound=true
        exit 0
    fi
    if [[ $sound == false ]]; then
        echo "$input"
    fi
}

main "$@"
