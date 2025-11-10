#!/usr/bin/env bash

# maps each character via atbash
atbash_char() {
    local c="$1"
    case "$c" in
        [a-z])
            # 'a' -> 'z', 'b' -> 'y', etc.
            printf "%s" "$(printf "%s" "$c" \
                | tr 'abcdefghijklmnopqrstuvwxyz' 'zyxwvutsrqponmlkjihgfedcba')"
            ;;
        [0-9])
            printf "%s" "$c"
            ;;
    esac
}

encode() {
    local input="$1"

    # sanitize: lowercase + only letters/digits
    local cleaned
    cleaned="$(printf "%s" "$input" \
        | tr '[:upper:]' '[:lower:]' \
        | sed 's/[^a-z0-9]//g')"

    local out=""
    local count=0

    local len="${#cleaned}"
    for ((i=0; i<len; i++)); do
        local ch="${cleaned:i:1}"

        # append safely (POSIX compatible)
        out="$(printf "%s%s" "$out" "$(atbash_char "$ch")")"

        ((count++))
        if (( count % 5 == 0 )); then
            out="$(printf "%s " "$out")"
        fi
    done

    printf "%s\n" "${out%" "}"
}

decode() {
    local input="$1"
    # remove all spaces, lowercase
    local cleaned
    cleaned="$(printf "%s" "$input" \
                | tr '[:upper:]' '[:lower:]' \
                | tr -d ' ')"

    local out=""
    for ((i=0; i<${#cleaned}; i++)); do
        local ch="${cleaned:i:1}"
        out+=$(atbash_char "$ch")
    done
    printf "%s\n" "$out"
}

main () {

        local op="${1:-}"
    local txt="${2:-}"

    if [[ "$op" == "encode" ]]; then
        encode "$txt"
    elif [[ "$op" == "decode" ]]; then
        decode "$txt"
    else
        exit 1
    fi

}

main "$@"
