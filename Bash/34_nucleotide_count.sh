#!/usr/bin/env bash

main () {
    chain=${1:-}
    length=${#chain}
    NA=0
    NC=0
    NG=0
    NT=0
    for (( i=0; i<length; i++)); do
        nucleotide=${chain:i:1}
        case "$nucleotide" in
            'A')
                ((NA += 1))
                ;;
            'C')
                ((NC += 1))
                ;;
            'G')
                ((NG += 1))
                ;;
            'T')
                ((NT += 1))
                ;;
            *)
                echo "Invalid nucleotide in strand" >&2
                exit 1
        esac
    done
    echo "A:" $NA
    echo "C:" $NC
    echo "G:" $NG
    echo "T:" $NT
}

main "$@"
