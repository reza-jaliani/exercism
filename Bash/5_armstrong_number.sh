#!/usr/bin/env bash

main () {
    number=${1:-0}
    armNumber=0
    length=${#number}
    
    for (( i=0; i<length; i++ )); do
        digit=${number:$i:1}
        armNumber=$(( armNumber + ( digit ** length ) ))
    done
    if [ "$number" -eq "$armNumber" ]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"
