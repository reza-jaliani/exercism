#!/usr/bin/env bash

# Validate input
if (( $# != 1 )) || ! [[ $1 =~ ^-?[0-9]+$ ]]; then
    echo "invalid input"
    exit 1
fi

n=$1

if (( n <= 0 )); then
    echo "invalid input"
    exit 1
fi

# Check primality
is_prime() {
    local num=$1
    local i

    # 1 is not prime
    (( num == 1 )) && return 1

    # check divisors up to sqrt(num)
    local limit=$(( num / 2 ))
    for (( i=2; i*i<=num; i++ )); do
        if (( num % i == 0 )); then
            return 1
        fi
    done

    return 0
}

count=0
candidate=1

# Loop until we find the n-th prime
while (( count < n )); do
    (( candidate++ ))
    if is_prime "$candidate"; then
        (( count++ ))
    fi
done

echo "$candidate"
