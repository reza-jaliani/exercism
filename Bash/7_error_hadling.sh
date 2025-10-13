#!/usr/bin/env bash
main () {
    if [ "$#" -eq 1 ]; then
        name=$1
        echo "Hello, ${name}"
    else
        echo "Usage: error_handling.sh <person>">&2
        exit 1
    fi
}
main "$@"
