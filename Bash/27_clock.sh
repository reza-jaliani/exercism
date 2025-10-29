#!/usr/bin/env bash

main () {
    if (( $# != 2 && $# != 4 )); then
        echo "invalid arguments"
        exit 1
    fi
    hour=${1:-0}
    minute=${2:-0}
    if ! [[ $hour =~ ^-?[0-9]+$ && $minute =~ ^-?[0-9]+$ ]]; then
        echo "invalid arguments"
        exit 1
    fi
    if (( $# == 4 )); then
        op=$3
        delta=$4
        if ! [[ $op =~ ^[+-]$ && $delta =~ ^-?[0-9]+$ ]]; then
            echo "invalid arguments"
            exit 1
        fi
        if [[ $op == "+" ]]; then
            ((minute += delta))
        elif [[ $op == "-" ]]; then
            ((minute -= delta))
        fi
    fi
    while (( minute < 0 )); do
        ((minute += 60))
        ((hour -= 1))
    done
    while (( hour < 0 )); do
        ((hour += 24))
    done
    ((hour += minute / 60))
    ((minute = minute % 60))
    ((hour = hour % 24))
    printf "%02d:%02d\n" "$hour" "$minute"
}

main "$@"
