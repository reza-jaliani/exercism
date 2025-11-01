#!/usr/bin/env bash

main() {
    local text=${1:-}
    local key=${2:-0}

    # Sanity check: key must be 0–26
    if (( key < 0 || key > 26 )); then
        echo "invalid key" >&2
        exit 1
    fi

    local result=""
    local char ascii shifted newchar

    for (( i=0; i<${#text}; i++ )); do
        char=${text:i:1}
        ascii=$(printf "%d" "'$char")

        # Uppercase A–Z (65–90)
        if (( ascii >= 65 && ascii <= 90 )); then
            shifted=$(( ((ascii - 65 + key) % 26) + 65 ))
            newchar=$(printf "\\$(printf '%03o' "$shifted")")
        # Lowercase a–z (97–122)
        elif (( ascii >= 97 && ascii <= 122 )); then
            shifted=$(( ((ascii - 97 + key) % 26) + 97 ))
            newchar=$(printf "\\$(printf '%03o' "$shifted")")
        else
            newchar=$char
        fi

        result+=$newchar
    done

    echo "$result"
}

main "$@"
