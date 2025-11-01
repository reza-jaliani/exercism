#!/usr/bin/env bash

main() {
    colors=(
        black
        brown
        red
        orange
        yellow
        green
        blue
        violet
        grey
        white
    )

    first_color=${1:-}
    second_color=${2:-}
    third_color=${3:-}

    get_color_index() {
        local color=$1
        for (( i=0; i<10; i++ )); do
            if [[ ${colors[i]} == "$color" ]]; then
                echo "$i"
                return 0
            fi
        done
        return 1
    }

    # Try to get indices; if any fails → print error and exit 1
    if ! first_digit=$(get_color_index "$first_color"); then
        echo "invalid color" >&2
        exit 1
    fi
    if ! second_digit=$(get_color_index "$second_color"); then
        echo "invalid color" >&2
        exit 1
    fi
    if ! third_digit=$(get_color_index "$third_color"); then
        echo "invalid color" >&2
        exit 1
    fi

    resistor=$(( (first_digit * 10 + second_digit) * (10 ** third_digit) ))

    if (( resistor == 0 )); then
        echo "0 ohms"
        return 0
    fi

    if (( resistor % 1000000000 == 0 )); then
        echo "$(( resistor / 1000000000 )) gigaohms"
    elif (( resistor % 1000000 == 0 )); then
        echo "$(( resistor / 1000000 )) megaohms"
    elif (( resistor % 1000 == 0 )); then
        echo "$(( resistor / 1000 )) kiloohms"
    else
        echo "${resistor} ohms"
    fi
}

main "$@"
