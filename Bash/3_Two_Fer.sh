#!/bin/bash
funcTwoFer () {
    local name="$1"
    if [ -n "$name" ]; then
        echo "One for $name, one for me."
    else
        echo "One for you, one for me."
    fi
}
main () {
    funcTwoFer "$1"
}
main "$@"
