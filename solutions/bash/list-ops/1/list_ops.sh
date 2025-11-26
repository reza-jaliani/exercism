#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "This library of functions should be sourced into another script" >&2
    exit 4
fi
bash_version=$((10 * BASH_VERSINFO[0] + BASH_VERSINFO[1]))
if (( bash_version < 43 )); then
    echo "This library requires at least bash version 4.3" >&2
    return 4
fi

list::append() {
    local -n __dst=$1
    shift
    __dst+=( "$@" )
}

list::filter() {
    local predicate=$1
    local -n __src=$2
    local -n __dst=$3

    __dst=()  # clear output

    for elem in "${__src[@]}"; do
        if "$predicate" "$elem"; then
            __dst+=( "$elem" )
        fi
    done
}

list::map() {
    local func=$1
    local -n __src=$2
    local -n __dst=$3

    __dst=()

    for elem in "${__src[@]}"; do
        newval="$("$func" "$elem")"
        __dst+=( "$newval" )
    done
}

list::foldl() {
    local func=$1
    local acc=$2
    local -n __src=$3

    for elem in "${__src[@]}"; do
        acc="$("$func" "$acc" "$elem")"
    done

    echo "$acc"
}

list::foldr() {
    local func=$1
    local acc=$2
    local -n __src=$3

    for (( i=${#__src[@]}-1; i>=0; i-- )); do
        elem="${__src[$i]}"
        acc="$("$func" "$elem" "$acc")"
    done

    echo "$acc"
}

list::reverse() {
    local -n __src=$1
    local -n __dst=$2

    __dst=()

    for (( i=${#__src[@]}-1; i>=0; i-- )); do
        __dst+=( "${__src[$i]}" )
    done
}
