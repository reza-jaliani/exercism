#!/usr/bin/env bash

main () {
    input=${1:-}
    trimmed=$(echo "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    if [[ -z $trimmed ]]; then
        echo "Fine. Be that way!"
    elif [[ $trimmed =~ [A-Z] && ! $trimmed =~ [a-z] && $trimmed == *\? ]]; then
        echo "Calm down, I know what I'm doing!"
    elif [[ $trimmed =~ [A-Z] && ! $trimmed =~ [a-z] ]]; then
        echo "Whoa, chill out!"
    elif [[ $trimmed == *\? ]]; then
        echo "Sure."
    else
        echo "Whatever."
    fi
}

main "$@"
