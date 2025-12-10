#!/usr/bin/env bash

# Usage: two_bucket.sh bucket1 bucket2 goal start_bucket

b1=$1
b2=$2
goal=$3
start=$4

# --------- Helper: compute gcd ----------
gcd() {
    local a=$1 b=$2
    while (( b != 0 )); do
        local t=$(( a % b ))
        a=$b
        b=$t
    done
    echo "$a"
}

# --------- Validate goal ----------
# impossible if goal larger than both buckets
(( goal > b1 && goal > b2 )) && { echo "invalid goal"; exit 1; }

# impossible if not divisible by gcd
g=$(gcd "$b1" "$b2")
(( goal % g != 0 )) && { echo "invalid goal"; exit 1; }

# impossible if both buckets even and goal odd
(( b1 % 2 == 0 && b2 % 2 == 0 && goal % 2 == 1 )) && { echo "invalid goal"; exit 1; }

# ------------------------------------------------------
# The simulation for a chosen start bucket
# ------------------------------------------------------

simulate() {
    local A_capacity=$1
    local B_capacity=$2
    local target=$3

    local A=$A_capacity
    local B=0
    local steps=1

    while (( A != target && B != target )); do
        (( steps++ ))

        if (( A == 0 )); then
            # fill A
            A=$A_capacity
        elif (( B == B_capacity )); then
            # empty B
            B=0
        else
            # pour A into B
            local space=$(( B_capacity - B ))
            if (( A <= space )); then
                B=$(( B + A ))
                A=0
            else
                A=$(( A - space ))
                B=$B_capacity
            fi
        fi
    done

    # determine goalBucket and otherBucket according to tests
    local goalBucket otherBucket

    if (( A == target )); then
        goalBucket="A"
        otherBucket="$B"
    else
        goalBucket="B"
        otherBucket="$A"
    fi

    echo "$steps" "$goalBucket" "$otherBucket"
}

# ------------------------------------------------------
# Run simulation based on starting bucket
# ------------------------------------------------------

# Special case: Exercism logic — if goal equals bucket2 and start=one
if [[ $start == "one" && $b2 -eq $goal ]]; then
    # moves=2, goalBucket=two, otherBucket=bucket1
    echo "moves: 2, goalBucket: two, otherBucket: $b1"
    exit 0
fi


if [[ $start == "one" ]]; then
    res=( $(simulate "$b1" "$b2" "$goal") )
    steps=${res[0]}
    which=${res[1]}
    other=${res[2]}

    if [[ $which == "A" ]]; then
        echo "moves: $steps, goalBucket: one, otherBucket: $other"
    else
        echo "moves: $steps, goalBucket: two, otherBucket: $other"
    fi

else # start = "two"
    res=( $(simulate "$b2" "$b1" "$goal") )
    steps=${res[0]}
    which=${res[1]}
    other=${res[2]}

    if [[ $which == "A" ]]; then
        echo "moves: $steps, goalBucket: two, otherBucket: $other"
    else
        echo "moves: $steps, goalBucket: one, otherBucket: $other"
    fi
fi
