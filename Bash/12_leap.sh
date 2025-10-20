#!/usr/bin/env bash
main() {
    year=$1
    extra=$2
    re='^[0-9]+$'
    if [[ -z $year || -n $extra || ! $year =~ $re ]]; then
        echo "Usage: leap.sh <year>" >&2
        exit 1
    fi
    if (( year % 400 == 0 )); then
        echo "true"
    elif (( year % 100 == 0 )); then
        echo "false"
    elif (( year % 4 == 0 )); then
        echo "true"
    else
        echo "false"
    fi
}
main "$@"
