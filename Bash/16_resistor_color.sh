#!/usr/bin/env bash

main() {
    # Array of resistor colors
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

    # First argument: action ("code" or "colors")
    action=$1
    # Second argument: color name (only used when action=code)
    color=$2

    case "$action" in
        code)
            case "$color" in
                black) echo 0 ;;
                brown) echo 1 ;;
                red) echo 2 ;;
                orange) echo 3 ;;
                yellow) echo 4 ;;
                green) echo 5 ;;
                blue) echo 6 ;;
                violet) echo 7 ;;
                grey) echo 8 ;;
                white) echo 9 ;;
                *)
                    echo "invalid color" >&2
                    exit 1
                    ;;
            esac
            ;;
        colors)
            for c in "${colors[@]}"; do
                echo "$c"
            done
            ;;
        *)
            echo "Usage: $0 {code <color>|colors}" >&2
            exit 1
            ;;
    esac
}

main "$@"
