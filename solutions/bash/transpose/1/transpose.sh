#!/usr/bin/env bash

main(){
    # Read all input, strip CRLF and BOM just in case
    clean_input=$(sed 's/\r$//' | sed '1s/^\xEF\xBB\xBF//')
    mapfile -t lines <<< "$clean_input"

    # Handle empty
    if (( ${#lines[@]} == 0 )) || { ((${#lines[@]} == 1)) && [[ -z "${lines[0]}" ]]; }; then
        exit 0
    fi

    # Determine longest line
    max_len=0
    for line in "${lines[@]}"; do
        (( ${#line} > max_len )) && max_len=${#line}
    done

    # Build transposed rows
    declare -a output=()

    for (( col=0; col<max_len; col++ )); do
        for (( r=0; r<${#lines[@]}; r++ )); do
            current="${lines[$r]}"
            char="${current:$col:1}"

            if [[ -n "$char" ]]; then
                # Pad left side if this is the first char in this transposed row
                while (( ${#output[$col]} < r )); do
                    output[$col]+=" "
                done
                output[$col]+="$char"
            fi
        done
    done

    # Print all rows with newline
    for row in "${output[@]}"; do
        printf "%s\n" "$row"
    done

    exit 0
}

main "$@"
