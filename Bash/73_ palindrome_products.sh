#!/usr/bin/env bash
set -euo pipefail

# Input validation
if (( $# != 3 )); then
    echo "first arg should be 'smallest' or 'largest'" >&2
    exit 1
fi

kind=$1
min=$2
max=$3

if [[ "$kind" != "smallest" && "$kind" != "largest" ]]; then
    echo "first arg should be 'smallest' or 'largest'" >&2
    exit 1
fi

if (( min > max )); then
    echo "min must be <= max" >&2
    exit 1
fi

# Helper: check palindrome
is_palindrome() {
    local n=$1
    local rev
    rev=$(echo "$n" | rev)
    [[ "$n" == "$rev" ]]
}

# Scan products
smallest=""
largest=""
declare -A small_factors
declare -A large_factors

for (( i=min; i<=max; i++ )); do
    for (( j=i; j<=max; j++ )); do
        prod=$(( i * j ))

        if is_palindrome "$prod"; then

            if [[ -z "$smallest" || prod < smallest ]]; then
                smallest="$prod"
                small_factors=()     # reset array
                small_factors["$i,$j"]=1
            elif [[ "$prod" == "$smallest" ]]; then
                small_factors["$i,$j"]=1
            fi

            if [[ -z "$largest" || prod > largest ]]; then
                largest="$prod"
                large_factors=()     # reset array
                large_factors["$i,$j"]=1
            elif [[ "$prod" == "$largest" ]]; then
                large_factors["$i,$j"]=1
            fi

        fi
    done
done

# Output logic
if [[ "$kind" == "smallest" ]]; then
    if [[ -z "$smallest" ]]; then
        exit 0   # no output
    fi
    printf "%s:" "$smallest"
    for key in "${!small_factors[@]}"; do
        IFS=',' read -r a b <<< "$key"
        printf " [%d, %d]" "$a" "$b"
    done
    echo
else
    if [[ -z "$largest" ]]; then
        exit 0   # no output
    fi
    printf "%s:" "$largest"
    for key in "${!large_factors[@]}"; do
        IFS=',' read -r a b <<< "$key"
        printf " [%d, %d]" "$a" "$b"
    done
    echo
fi
