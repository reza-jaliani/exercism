#!/usr/bin/env bash
main() {
    parts=(
        "the house that Jack built."
        "the malt"
        "the rat"
        "the cat"
        "the dog"
        "the cow with the crumpled horn"
        "the maiden all forlorn"
        "the man all tattered and torn"
        "the priest all shaven and shorn"
        "the rooster that crowed in the morn"
        "the farmer sowing his corn"
        "the horse and the hound and the horn"
    )
    actions=(
        ""
        "lay in"
        "ate"
        "killed"
        "worried"
        "tossed"
        "milked"
        "kissed"
        "married"
        "woke"
        "kept"
        "belonged to"
    )
    start=${1:-1}
    end=${2:-${#parts[@]}}
    max=${#parts[@]}
    if (( start < 1 || end < 1 || start > max || end > max || start > end )); then
        echo "invalid"
        exit 1
    fi
    for ((i=start-1; i<end; i++)); do
        echo "This is ${parts[i]}"
        for ((j=i; j>0; j--)); do
            echo "that ${actions[j]} ${parts[j-1]}"
        done
        echo
    done
}
main "$@"
