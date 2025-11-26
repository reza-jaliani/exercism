#!/usr/bin/env bash

declare -A decode_matrix
decode_matrix[" _ | ||_|   "]=0
decode_matrix["     |  |   "]=1
decode_matrix[" _  _||_    "]=2
decode_matrix[" _  _| _|   "]=3
decode_matrix["   |_|  |   "]=4
decode_matrix[" _ |_  _|   "]=5
decode_matrix[" _ |_ |_|   "]=6
decode_matrix[" _   |  |   "]=7
decode_matrix[" _ |_||_|   "]=8
decode_matrix[" _ |_| _|   "]=9


main () {
    ## read the input
    declare -a lines
    while IFS=$'\n' read -r line; do
        lines+=( "$line" )
    done

    ## error handling
    (( ${#lines[@]} % 4 != 0 )) && { echo "Number of input lines is not a multiple of four"; exit 1; }
    for line in "${lines[@]}"; do
        (( ${#line} % 3 != 0 )) && { echo "Number of input columns is not a multiple of three"; exit 1; }
    done

    ## process the intput
    output=
    for ((i=0; i<${#lines[@]}; i+=4)); do
        for ((j=0; j<${#lines[$i]}; j+=3)); do
            num="${lines[i]:j:3}${lines[i+1]:j:3}${lines[i+2]:j:3}${lines[i+3]:j:3}"
            output+="${decode_matrix[$num]:-?}"
        done
        output+=","
    done
    
    ## print the output
    echo "${output%,}"
}

main "$@"