#!/usr/bin/env bash

verse() {
    local n=$1

    local animals=(
        fly
        spider
        bird
        cat
        dog
        goat
        cow
        horse
    )

    local comments=(
        ""
        "It wriggled and jiggled and tickled inside her."
        "How absurd to swallow a bird!"
        "Imagine that, to swallow a cat!"
        "What a hog, to swallow a dog!"
        "Just opened her throat and swallowed a goat!"
        "I don't know how she swallowed a cow!"
        ""
    )

    local idx=$((n - 1))
    local animal=${animals[$idx]}
    local comment=${comments[$idx]}

    echo "I know an old lady who swallowed a $animal."
    [[ -n $comment ]] && echo "$comment"

    if [[ $animal == "horse" ]]; then
        echo "She's dead, of course!"
        return 0
    fi

    for ((i = idx; i > 0; i--)); do
        local predator=${animals[$i]}
        local prey=${animals[$((i - 1))]}

        if [[ $predator == "bird" && $prey == "spider" ]]; then
            echo "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
        else
            echo "She swallowed the $predator to catch the $prey."
        fi
    done

    echo "I don't know why she swallowed the fly. Perhaps she'll die."
}

main() {
    if (( $# != 2 )); then
        echo "2 arguments expected"
        exit 1
    fi

    local start=$1 end=$2
    if (( start > end )); then
        echo "Start must be less than or equal to End"
        exit 1
    fi

    for ((v = start; v <= end; v++)); do
        verse "$v"
        (( v < end )) && echo ""
    done
}

main "$@"
exit 0
