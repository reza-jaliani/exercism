#!/usr/bin/env bash

main () {
    normalize(){
        echo "$1" | sed "s/,//g; s/-/ /g; s/'//g; s/\\_//g; s/\*//g;" 
    }
    A=$1
    read -r -a input <<<"$(normalize "$A")"
    length=${#input[@]}
    for (( i=0; i < length; i++ )); do
        acronym+=${input[i]:0:1}
    done
    echo "$acronym" | tr '[:lower:]' '[:upper:]'
}

main "$@"
