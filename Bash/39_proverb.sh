#!/usr/bin/env bash

main() {
    # Read all arguments as an array
    items=("$@")
    length=${#items[@]}

    # If empty input → nothing to print
    (( length == 0 )) && exit 0

    # Loop through all pairs except the last
    for (( i=0; i<length-1; i++ )); do
        echo "For want of a ${items[i]} the ${items[i+1]} was lost."
    done

    # Final line
    echo "And all for the want of a ${items[0]}."
}

main "$@"
