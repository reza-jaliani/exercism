#!/usr/bin/env bash

category="$1"
shift
dice=("$@")

# Sort dice (strings so spaces stay consistent)
sorted=($(printf "%s\n" "${dice[@]}" | sort -n))

# Count occurrences
count() {
    local target=$1 c=0
    for d in "${dice[@]}"; do
        [[ "$d" -eq "$target" ]] && ((c++))
    done
    echo "$c"
}

# Check Yacht
is_yacht() {
    local first="${dice[0]}"
    for d in "${dice[@]}"; do
        [[ "$d" -ne "$first" ]] && return 1
    done
    return 0
}


case "$category" in

    yacht)
        if is_yacht; then
            echo 50
        else
            echo 0
        fi
        exit 0
        ;;

    ones|twos|threes|fours|fives|sixes)
        n=0
        case "$category" in
            ones) n=1 ;;
            twos) n=2 ;;
            threes) n=3 ;;
            fours) n=4 ;;
            fives) n=5 ;;
            sixes) n=6 ;;
        esac
        echo $(( n * $(count "$n") ))
        exit 0
        ;;

    "full house")
        declare -A freq=()
        for d in "${dice[@]}"; do ((freq[$d]++)); done

        # must be exactly 2 distinct values
        [[ ${#freq[@]} -ne 2 ]] && echo 0 && exit 0

        # one must be 2x and one must be 3x
        has2=0; has3=0
        for c in "${freq[@]}"; do
            [[ $c -eq 2 ]] && has2=1
            [[ $c -eq 3 ]] && has3=1
        done

        if [[ $has2 -eq 1 && $has3 -eq 1 ]]; then
            total=0
            for d in "${dice[@]}"; do ((total+=d)); done
            echo "$total"
        else
            echo 0
        fi
        exit 0
        ;;

    "four of a kind")
        declare -A freq2=()
        for d in "${dice[@]}"; do ((freq2[$d]++)); done

        for face in "${!freq2[@]}"; do
            if [[ ${freq2[$face]} -ge 4 ]]; then
                echo $((face * 4))
                exit 0
            fi
        done

        echo 0
        exit 0
        ;;

    "little straight")
        if [[ "${sorted[*]}" == "1 2 3 4 5" ]]; then
            echo 30
        else
            echo 0
        fi
        exit 0
        ;;

    "big straight")
        if [[ "${sorted[*]}" == "2 3 4 5 6" ]]; then
            echo 30
        else
            echo 0
        fi
        exit 0
        ;;

    choice)
        sum=0
        for d in "${dice[@]}"; do ((sum+=d)); done
        echo "$sum"
        exit 0
        ;;

esac
