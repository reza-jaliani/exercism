#!/usr/bin/env bash

set -e

m=26

# greatest common divisor
gcd() {
    local a=$1 b=$2
    while (( b != 0 )); do
        local t=$b
        b=$(( a % b ))
        a=$t
    done
    echo "$a"
}

# modular multiplicative inverse of a mod 26
mmi() {
    local a=$1
    for ((i=1; i<m; i++)); do
        if (( (a * i) % m == 1 )); then
            echo "$i"
            return
        fi
    done
    echo -1
}

encode() {
    local a=$1 b=$2 text="${3,,}"
    local out=""

    # keep only letters + digits (digits unencrypted)
    text=$(echo "$text" | tr -cd 'a-zA-Z0-9' | tr A-Z a-z)

    for ((i=0; i<${#text}; i++)); do
        ch=${text:i:1}

        if [[ "$ch" =~ [0-9] ]]; then
            out+="$ch"
        else
            x=$(( $(printf "%d" "'$ch") - 97 ))
            y=$(( (a * x + b) % 26 ))
            out+=$(printf "\\$(printf "%03o" $((y + 97)) )")
        fi
    done

    # group output into 5s
    echo "$out" | sed -E 's/.{1,5}/& /g' | sed 's/ $//'
}

decode() {
    local a=$1 b=$2 text="${3,,}"
    local out=""

    # remove invalid chars
    text=$(echo "$text" | tr -cd 'a-zA-Z0-9' | tr A-Z a-z)

    ainv=$(mmi "$a")
    if (( ainv == -1 )); then
        echo "a and m must be coprime."
        exit 1
    fi

    for ((i=0; i<${#text}; i++)); do
        ch=${text:i:1}

        if [[ "$ch" =~ [0-9] ]]; then
            out+="$ch"
        else
            y=$(( $(printf "%d" "'$ch") - 97 ))

            # normalize (y - b) mod 26 to range 0–25
            norm=$(( (y - b) % 26 ))
            (( norm < 0 )) && norm=$(( norm + 26 ))

            x=$(( (ainv * norm) % 26 ))
            (( x < 0 )) && x=$(( x + 26 ))

            out+=$(printf "\\$(printf "%03o" $((x + 97)) )")
        fi
    done

    echo "$out"
}

main() {
    local mode="$1" a="$2" b="$3"
    shift 3
    local text="$*"

    # validate a is coprime with m=26
    if (( $(gcd "$a" 26) != 1 )); then
        echo "a and m must be coprime."
        exit 1
    fi

    case "$mode" in
        encode) encode "$a" "$b" "$text" ;;
        decode) decode "$a" "$b" "$text" ;;
        *) echo "Unknown command"; exit 1 ;;
    esac
}

main "$@"
