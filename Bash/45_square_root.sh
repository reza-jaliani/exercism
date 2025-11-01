#!/usr/bin/env bash
main () {
    number=${1:-}
    for (( i=0; i<=$number; i++ )); do
        (( number == (i**2) )) && echo $i && exit 0
    done
}
main "$@"
