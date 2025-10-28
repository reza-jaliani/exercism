#!/usr/bin/env bash

main() {
    declare -a number=(
        [10]=Ten
        [9]=Nine
        [8]=Eight
        [7]=Seven
        [6]=Six
        [5]=Five
        [4]=Four
        [3]=Three
        [2]=Two
        [1]=One
    )

    start=${1:-}
    end=${2:-}
    check=$3

    if [[ -n $check || -z $end || -z $start ]]; then
        echo "2 arguments expected" >&2
        exit 1
    elif (( end > start )); then
        echo "cannot generate more verses than bottles" >&2
        exit 1
    fi

    for (( i = 0; i < end; i++ )); do
        if (( start > 2 )); then
            printf "%s green bottles hanging on the wall,\n" "${number[start]}"
            printf "%s green bottles hanging on the wall,\n" "${number[start]}"
            printf "And if one green bottle should accidentally fall,\n"
            printf "There'll be %s green bottles hanging on the wall.\n" "$(echo "${number[start - 1]}" | tr '[:upper:]' '[:lower:]')"
        elif (( start == 2 )); then
            printf "Two green bottles hanging on the wall,\n"
            printf "Two green bottles hanging on the wall,\n"
            printf "And if one green bottle should accidentally fall,\n"
            printf "There'll be one green bottle hanging on the wall.\n"
        elif (( start == 1 )); then
            printf "One green bottle hanging on the wall,\n"
            printf "One green bottle hanging on the wall,\n"
            printf "And if one green bottle should accidentally fall,\n"
            printf "There'll be no green bottles hanging on the wall.\n"
        fi

        ((start--))

        # print blank line *between* verses, not after last one
        if (( i < end - 1 )); then
            printf "\n"
        fi
    done
}

main "$@"
