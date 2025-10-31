#!/usr/bin/env bash

main() {
    codon=${1:-}
    length=${#codon}

    # Empty input is valid
    if [[ -z "$codon" ]]; then
        echo -n ""
        exit 0
    fi

    # Validate allowed characters (A–Z)
    if [[ ! "$codon" =~ ^[A-Z]+$ ]]; then
        echo "Invalid codon"
        exit 1
    fi

    i=0
    stopped=0
    protein=""

    while (( i + 3 <= length )); do
        substring=${codon:i:3}
        case "$substring" in
            "AUG") aa="Methionine" ;;
            "UUU"|"UUC") aa="Phenylalanine" ;;
            "UUA"|"UUG") aa="Leucine" ;;
            "UCU"|"UCC"|"UCA"|"UCG") aa="Serine" ;;
            "UAU"|"UAC") aa="Tyrosine" ;;
            "UGU"|"UGC") aa="Cysteine" ;;
            "UGG") aa="Tryptophan" ;;
            "UAA"|"UAG"|"UGA")
                stopped=1
                break
                ;;
            *) echo "Invalid codon"; exit 1 ;;
        esac

        if [[ -n "$protein" ]]; then
            protein+=" "
        fi
        protein+="$aa"

        (( i += 3 ))
    done

    # If we didn’t stop and leftover nucleotides remain → invalid
    if (( !stopped )) && (( length % 3 != 0 )); then
        echo "Invalid codon"
        exit 1
    fi

    # Print final result
    echo -n "$protein"
    exit 0
}

main "$@"
