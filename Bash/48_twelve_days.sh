#!/usr/bin/env bash

main () {
    days=(
        "first"
        "second"
        "third"
        "fourth"
        "fifth"
        "sixth"
        "seventh"
        "eighth"
        "ninth"
        "tenth"
        "eleventh"
        "twelfth"
    )
    gifts=(
        "a Partridge in a Pear Tree."
        "two Turtle Doves, "
        "three French Hens, "
        "four Calling Birds, "
        "five Gold Rings, "
        "six Geese-a-Laying, "
        "seven Swans-a-Swimming, "
        "eight Maids-a-Milking, "
        "nine Ladies Dancing, "
        "ten Lords-a-Leaping, "
        "eleven Pipers Piping, "
        "twelve Drummers Drumming, "
    )
    start=${1:-1}
    end=${2:-12}
    for (( i=start; i<=end; i++ )); do
        echo -n "On the ${days[i-1]} day of Christmas my true love gave to me: "
        for (( j=i; j>=1; j-- )); do
            if (( j == 1 && i != 1 )); then
                echo -n "and ${gifts[0]}"
            else
                echo -n "${gifts[j-1]}"
            fi
        done
        echo 
    done
}

main "$@"
