#!/usr/bin/env bash

main () {
    sequence=${1:-}
    output=${2:-}
    input_length=${#sequence}
    if [[ -z $sequence ]]; then
        echo "" >&2
        exit 0
    fi
    for (( i=0; i<input_length; i++ )); do
        case ${sequence:i:1} in
            "C")
                output="${output}G"
                ;;
            "G")
                output="${output}C"
                ;;
            "T")
                output="${output}A"
                ;;
            "A")
                output="${output}U"
                ;;
            *)
                echo "Invalid nucleotide detected." >&2
                exit 1
                ;;
        esac
    done
    echo $output
}

main "$@"
