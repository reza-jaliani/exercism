#!/usr/bin/env bash

main() {
    number=$1
    actions=()
    (( number & 1 )) && actions+=("wink")
    (( number & 2 )) && actions+=("double blink")
    (( number & 4 )) && actions+=("close your eyes")
    (( number & 8 )) && actions+=("jump")
    if (( number & 16 )); then
        for (( i=${#actions[@]}-1; i>=0; i-- )); do
            reversed+=("${actions[i]}")
        done
        actions=("${reversed[@]}")
    fi
    (IFS=','; echo "${actions[*]}")
}
main "$@"
