#!/usr/bin/env bash
main() {
    number=${1:-}
    if [[ -z "$number" || "$number" -le 0 ]]; then
        echo "Classification is only possible for natural numbers."
        exit 1
    fi
    sum=1
    if (( number == 1 )); then
        echo "deficient"
        exit 0
    fi
    sqrt=$(awk -v n="$number" 'BEGIN { printf "%d", sqrt(n) }')
    for (( i=2; i<=sqrt; i++ )); do
        if (( number % i == 0 )); then
            (( sum += i ))
            other=$(( number / i ))
            if (( other != i )); then
                (( sum += other ))
            fi
        fi
    done
    if (( sum == number )); then
        echo "perfect"
    elif (( sum > number )); then
        echo "abundant"
    else
        echo "deficient"
    fi
}
main "$@"
