#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-}"
shift || true

hex_to_dec() { printf "%d" "0x$1"; }

encode_one() {
    local n out=()
    n="$(hex_to_dec "$1")"

    # special case: zero must encode to "00"
    if (( n == 0 )); then
        printf "00"
        return
    fi

    while (( n > 0 )); do
        out+=( $(( n & 0x7F )) )
        n=$(( n >> 7 ))
    done

    local result=()
    for (( i=${#out[@]}-1; i>=0; i-- )); do
        local b="${out[i]}"
        if (( i != 0 )); then
            b=$(( b | 0x80 ))
        fi
        result+=( "$(printf "%02X" "$b")" )
    done

    printf "%s" "${result[*]}"
}

decode_bytes() {
    local values=()
    local cur=0
    local has_cont=0

    for byte_hex in "$@"; do
        local b=$(( 0x$byte_hex ))

        local data=$(( b & 0x7F ))
        local cont=$(( b & 0x80 ))

        cur=$(( (cur << 7) | data ))

        if (( cont == 0 )); then
            # always print two-digit hex when needed
            if (( cur == 0 )); then
                hx="00"
            else
                printf -v hx "%X" "$cur"
            fi
            values+=( "$hx" )
            cur=0
            has_cont=0
        else
            has_cont=1
        fi
    done

    if (( has_cont == 1 )); then
        echo "incomplete byte sequence" >&2
        exit 1
    fi

    printf "%s" "${values[*]}"
}

case "$cmd" in
    encode)
        out=()
        for val in "$@"; do
            out+=( "$(encode_one "$val")" )
        done
        printf "%s" "${out[*]}"
        ;;
    decode)
        decode_bytes "$@"
        ;;
    *)
        echo "unknown subcommand: $cmd" >&2
        exit 1
        ;;
esac
