#!/usr/bin/env bash

main() {
    colors=(
        "black"
        "brown"
        "red"
        "orange"
        "yellow"
        "green"
        "blue"
        "violet"
        "grey"
        "white"
    )
    color1=$1
    color2=$2
    if [[ $color1 != "black" ]]; then
        case "$color1" in
            black)
                echo -n 0
                ;;
            brown)
                echo -n 1
                ;;
            red)
                echo -n 2
                ;;
            orange)
                echo -n 3
                ;;
            yellow)
                echo -n 4
                ;;
            green)
                echo -n 5
                ;;
            blue)
                echo -n 6
                ;;
            violet)
                echo -n 7
                ;;
            grey)
                echo -n 8
                ;;
            white)
                echo -n 9
                ;;
            *)
                echo "invalid color" >&2
                exit 1
                ;;
        esac
    fi
    case "$color2" in
        black)
            echo -n 0
            ;;
        brown)
            echo -n 1
            ;;
        red)
            echo -n 2
            ;;
        orange)
            echo -n 3
            ;;
        yellow)
            echo -n 4
            ;;
        green)
            echo -n 5
            ;;
        blue)
            echo -n 6
            ;;
        violet)
            echo -n 7
            ;;
        grey)
            echo -n 8
            ;;
        white)
            echo -n 9
            ;;
        *)
            echo "invalid color" >&2
            exit 1
            ;;
    esac
}
main "$@"
