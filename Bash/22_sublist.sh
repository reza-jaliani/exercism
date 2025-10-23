#!/usr/bin/env bash
main() {
    A="$1"
    B="$2"
    normalize() {
        echo "$1" | sed 's/\[//g; s/\]//g; s/,//g; s/  */ /g; s/^ *//; s/ *$//'
    }
    read -r -a arrA <<<"$(normalize "$A")"
    read -r -a arrB <<<"$(normalize "$B")"
    lenA=${#arrA[@]}
    lenB=${#arrB[@]}
    if (( lenA == 0 && lenB == 0 )); then
        echo "equal"; return
    elif (( lenA == 0 )); then
        echo "sublist"; return
    elif (( lenB == 0 )); then
        echo "superlist"; return
    fi
    if [[ "${arrA[*]}" == "${arrB[*]}" ]]; then
        echo "equal"; return
    fi
    is_sublist() {
        local -n small=$1
        local -n big=$2
        local len_small=${#small[@]}
        local len_big=${#big[@]}
        for ((i = 0; i + len_small <= len_big; i++)); do
            match=true
            for ((j = 0; j < len_small; j++)); do
                if [[ ${small[j]} != ${big[i+j]} ]]; then
                    match=false; break
                fi
            done
            $match && return 0
        done
        return 1
    }
    if is_sublist arrA arrB; then
        echo "sublist"
    elif is_sublist arrB arrA; then
        echo "superlist"
    else
        echo "unequal"
    fi
}
main "$@"
