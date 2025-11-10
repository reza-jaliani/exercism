#!/usr/bin/env bash
set -euo pipefail

letters=( {A..Z} )

main() {
    letter=${1:-}

    # Find index of the target letter
    for i in "${!letters[@]}"; do
        if [[ "$letter" == "${letters[$i]}" ]]; then
            target=$i
            break
        fi
    done

    # Total width of diamond
    width=$(( 2 * target + 1 ))

    # Top half (including middle)
    for ((row=0; row<=target; row++)); do
        print_row "$row" "$target" "$width"
    done

    # Bottom half
    for ((row=target-1; row>=0; row--)); do
        print_row "$row" "$target" "$width"
    done
}

print_row() {
    local row=$1
    local max=$2
    local width=$3

    local left=$(( max - row ))
    local inner=$(( row == 0 ? 0 : row*2 - 1 ))

    # Build line in variable
    line="$(printf "%*s" "$left" "")"

    line+="${letters[$row]}"

    if (( row > 0 )); then
        line+="$(printf "%*s" "$inner" "")${letters[$row]}"
    fi

    # Pad to full width (trailing spaces)
    printf "%-*s\n" "$width" "$line"
}

main "$@"
