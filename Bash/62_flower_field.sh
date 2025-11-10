#!/usr/bin/env bash

main() {
    local -a board=("$@")
    local rows=${#board[@]}
    (( rows == 0 )) && return 0

    local cols=${#board[0]}
    local -a out=()

    # Safe getter that never errors
    get() {
        local r=$1 c=$2
        if (( r<0 || r>=rows || c<0 || c>=${#board[$r]} )); then
            echo ""
        else
            echo "${board[$r]:$c:1}"
        fi
    }

    for ((r=0; r<rows; r++)); do
        local newrow=""
        local thislen=${#board[$r]}

        for ((c=0; c<thislen; c++)); do
            local cell
            cell=$(get "$r" "$c")

            if [[ $cell == "*" ]]; then
                newrow+="*"
                continue
            fi

            local count=0
            for dr in -1 0 1; do
                for dc in -1 0 1; do
                    (( dr==0 && dc==0 )) && continue

                    if [[ $(get $((r+dr)) $((c+dc))) == "*" ]]; then
                        ((count++))
                    fi
                done
            done

            if ((count == 0)); then
                newrow+=" "
            else
                newrow+="$count"
            fi
        done

        out+=("$newrow")
    done

    printf "%s\n" "${out[@]}"
}

main "$@"
