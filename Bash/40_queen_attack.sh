#!/usr/bin/env bash

main () {
    white=${2:-}
    black=${4:-}
    horizontal_white="${white%,*}"
    vertical_white="${white#*,}"
    horizontal_black="${black%,*}"
    vertical_black="${black#*,}"
    if (( horizontal_white < 0 || horizontal_black < 0 )); then
        echo "row not positive" >&2
        exit 1
    elif (( vertical_white < 0 || vertical_black < 0 )); then
        echo "column not positive" >&2
        exit 1
    elif (( horizontal_white > 7 || horizontal_black > 7 )); then
        echo "row not on board" >&2
        exit 1
    elif (( vertical_white > 7 || vertical_black > 7 )); then
        echo "column not on board" >&2
        exit 1
    elif (( horizontal_white == horizontal_black && vertical_white == vertical_black )); then
        echo "same position" >&2
        exit 1
    fi
    horizontal_distance=$(( horizontal_white - horizontal_black ))
    vertical_distance=$(( vertical_white - vertical_black ))
    (( horizontal_distance < 0)) && horizontal_distance=$(( -horizontal_distance))
    (( vertical_distance < 0 )) && vertical_distance=$(( -vertical_distance ))
    if (( vertical_distance == 0 || horizontal_distance == 0 || horizontal_distance == vertical_distance )); then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"
