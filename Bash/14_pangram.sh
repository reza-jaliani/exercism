#!/usr/bin/env bash

main () {
    sentence="$1"
    letters=$(echo "$sentence" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z')
    unique=$(echo "$letters" | fold -w1 | sort -u | tr -d '\n')
    count=$(echo -n "$unique" | wc -c)
    if [ "$count" -eq 26 ]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"
