#!/usr/bin/env bash

main() {
    # --- Input validation ---
    if (( $# < 1 )); then
        # No arguments at all -> error
        exit 1
    fi

    local max_wt=$1
    shift

    # If no items -> output 0
    if (( $# == 0 )); then
        echo "0"
        exit 0
    fi

    # --- Parse items into arrays ---
    local weights=()
    local values=()

    for item in "$@"; do
        # Must be of form weight:value
        if [[ "$item" =~ ^([0-9]+):([0-9]+)$ ]]; then
            weights+=("${BASH_REMATCH[1]}")
            values+=("${BASH_REMATCH[2]}")
        fi
    done

    local n=${#weights[@]}

    # --- DP array (1D) ---
    # dp[w] = best value achievable with capacity w
    local -a dp
    for (( i=0; i<=max_wt; i++ )); do
        dp[i]=0
    done

    # --- Knapsack DP ---
    for (( i=0; i<n; i++ )); do
        local wt=${weights[i]}
        local val=${values[i]}

        # iterate backwards to avoid reuse of same item
        for (( w=max_wt; w>=wt; w-- )); do
            local new=$(( dp[w-wt] + val ))
            if (( new > dp[w] )); then
                dp[w]=$new
            fi
        done
    done

    echo "${dp[$max_wt]}"
}

main "$@"
