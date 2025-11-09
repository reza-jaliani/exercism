#!/usr/bin/env bash
set -euo pipefail

translate_word() {
    local w=$1

    # Rule 1: starts with vowel or xr / yt
    if [[ $w =~ ^[aeiou] ]]; then
        echo "${w}ay"
        return
    fi
    if [[ $w =~ ^xr ]] || [[ $w =~ ^yt ]]; then
        echo "${w}ay"
        return
    fi

    # Rule 3: consonants + qu
    if [[ $w =~ ^([^aeiou]*qu)(.*) ]]; then
        echo "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay"
        return
    fi

    # Rule 4: consonants ending at y
    if [[ $w =~ ^([^aeiou]+)(y.*) ]]; then
        echo "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay"
        return
    fi

    # Rule 2: normal consonant cluster
    if [[ $w =~ ^([^aeiou]+)(.*) ]]; then
        echo "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay"
        return
    fi

    # fallback
    echo "${w}ay"
}

main() {
    local output=()

    for word in "$@"; do
        output+=( "$(translate_word "$word")" )
    done

    printf "%s\n" "${output[*]}"
}

main "$@"
