#!/usr/bin/env bash

main () {
    passage=${1:-}
    declare -a stack=()
    for (( i=0; i<${#passage}; i++ )); do
        ch=${passage:i:1}
        case "$ch" in
            '('|'['|'{')
                stack+=("$ch")
                ;;
            ')')
                [[ ${#stack[@]} -eq 0 || ${stack[-1]} != '(' ]] && echo "false" && exit 0
                unset 'stack[-1]'
                ;;
            ']')
                [[ ${#stack[@]} -eq 0 || ${stack[-1]} != '[' ]] && echo "false" && exit 0
                unset 'stack[-1]'
                ;;
            '}')
                [[ ${#stack[@]} -eq 0 || ${stack[-1]} != '{' ]] && echo "false" && exit 0
                unset 'stack[-1]'
                ;;
            *)
                ;;
        esac
    done
    if [[ ${#stack[@]} -eq 0 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"
