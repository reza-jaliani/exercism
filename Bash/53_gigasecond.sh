#!/usr/bin/env bash

main () {
    input="$*"

    epoch=$(date -d "$input" +%s)
    giga=$((epoch + 1000000000))

    # Format with the 'T' separator
    printf '%(%Y-%m-%dT%H:%M:%S)T\n' "$giga"
}

main "$@"
