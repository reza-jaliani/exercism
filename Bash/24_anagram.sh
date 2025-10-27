#!/usr/bin/env bash
sort_word() {
    echo "$1" | grep -o . | sort | tr -d '\n'
}
main() {
    target=$1
    shift
    candidates=($@)
    target_lower=$(echo "$target" | tr '[:upper:]' '[:lower:]')
    target_sorted=$(sort_word "$target_lower")
    result=""
    for word in "${candidates[@]}"; do
        word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
        if [[ "$word_lower" == "$target_lower" ]]; then
            continue
        fi
        if [[ "$(sort_word "$word_lower")" == "$target_sorted" ]]; then
            result+="$word "
        fi
    done
    echo "${result%" "}"
}
main "$@"
