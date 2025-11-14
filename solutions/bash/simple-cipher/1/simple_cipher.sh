#!/usr/bin/env bash

set -e

# Convert letter → 0-25 index
to_idx() {
    printf "%d" $(( $(printf "%d" "'$1") - 97 ))
}

# Convert 0-25 index → letter
to_chr() {
    printf "\\$(printf "%03o" $(( $1 + 97 )) )"
}

# Generate random key
generate_key() {
    tr -dc a-z </dev/urandom | head -c 100
}

validate_key() {
    [[ "$1" =~ ^[a-z]+$ ]] || { echo "invalid key"; exit 1; }
}

encode() {
    local key="$1"
    local txt="${2,,}"
    local out=""
    local keylen=${#key}

    for ((i=0; i<${#txt}; i++)); do
        p=${txt:i:1}
        k=${key:i%keylen:1}

        pi=$(to_idx "$p")
        ki=$(to_idx "$k")

        ci=$(( (pi + ki) % 26 ))
        out+=$(to_chr "$ci")
    done

    echo "$out"
}

decode() {
    local key="$1"
    local txt="${2,,}"
    local out=""
    local keylen=${#key}

    for ((i=0; i<${#txt}; i++)); do
        c=${txt:i:1}
        k=${key:i%keylen:1}

        ci=$(to_idx "$c")
        ki=$(to_idx "$k")

        pi=$(( (ci - ki + 26) % 26 ))
        out+=$(to_chr "$pi")
    done

    echo "$out"
}

main() {
    if [[ "$1" == "key" ]]; then
        generate_key
        exit 0
    fi

    if [[ "$1" == "-k" ]]; then
        key="$2"
        validate_key "$key"

        mode="$3"
        text="$4"

        case "$mode" in
            encode) encode "$key" "$text" ;;
            decode) decode "$key" "$text" ;;
            *) echo "unknown command"; exit 1 ;;
        esac
    else
        echo "Usage: simple_cipher.sh key | -k key (encode|decode) text"
        exit 1
    fi
}

main "$@"
