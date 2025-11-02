#!/usr/bin/env bash

main () {
    triangle=${1:-}
    a=${2:-0}
    b=${3:-0}
    c=${4:-0}

    # Function to compare two float numbers
    eq() { echo "$1 == $2" | bc -l; }
    gt() { echo "$1 > $2" | bc -l; }
    ge() { echo "$1 >= $2" | bc -l; }

    # Validate sides are positive
    if [ "$(gt "$a" 0)" -eq 0 ] || [ "$(gt "$b" 0)" -eq 0 ] || [ "$(gt "$c" 0)" -eq 0 ]; then
        echo "false"
        exit 0
    fi

    # Validate triangle inequality
    if [ "$(ge "$(echo "$a + $b" | bc -l)" "$c")" -eq 0 ] ||
   [ "$(ge "$(echo "$b + $c" | bc -l)" "$a")" -eq 0 ] ||
   [ "$(ge "$(echo "$a + $c" | bc -l)" "$b")" -eq 0 ]; then
        echo "false"
        exit 0
    fi

    case $triangle in
    equilateral)
        if [ "$(eq "$a" "$b")" -eq 1 ] && [ "$(eq "$b" "$c")" -eq 1 ]; then
            echo "true"
        else
            echo "false"
        fi
        ;;
    isosceles)
        if [ "$(eq "$a" "$b")" -eq 1 ] || [ "$(eq "$a" "$c")" -eq 1 ] || [ "$(eq "$b" "$c")" -eq 1 ]; then
            echo "true"
        else
            echo "false"
        fi
        ;;
    scalene)
        if [ "$(eq "$a" "$b")" -eq 0 ] && [ "$(eq "$a" "$c")" -eq 0 ] && [ "$(eq "$b" "$c")" -eq 0 ]; then
            echo "true"
        else
            echo "false"
        fi
        ;;
    *)
        echo "false"
        ;;
esac
    
}

main "$@"
