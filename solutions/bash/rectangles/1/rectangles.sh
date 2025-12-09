#!/usr/bin/env bash

# Read all input lines into array "grid"
mapfile -t grid

rows=${#grid[@]}
(( rows == 0 )) && echo 0 && exit 0
cols=${#grid[0]}

# Safe char lookup
char_at() {
    local r=$1 c=$2
    printf "%s" "${grid[r]:c:1}"
}

is_corner() {
    [[ "$1" == "+" ]]
}

is_hline() {
    [[ "$1" == "+" || "$1" == "-" ]]
}

is_vline() {
    [[ "$1" == "+" || "$1" == "|" ]]
}

count=0

# Iterate over all possible top-left corners
for (( r1=0; r1<rows; r1++ )); do
    for (( c1=0; c1<cols; c1++ )); do
        if ! is_corner "$(char_at $r1 $c1)"; then
            continue
        fi

        # Find all possible top-right corners on same row
        for (( c2=c1+1; c2<cols; c2++ )); do
            ch=$(char_at $r1 $c2)
            if ! is_corner "$ch"; then
                continue
            fi

            # Ensure horizontal top edge is valid
            valid_top=true
            for (( c=c1+1; c<c2; c++ )); do
                t=$(char_at $r1 $c)
                if ! is_hline "$t"; then
                    valid_top=false
                    break
                fi
            done
            $valid_top || continue

            # Now search for bottom corners
            for (( r2=r1+1; r2<rows; r2++ )); do
                # bottom-left candidate
                bl=$(char_at $r2 $c1)
                # bottom-right candidate
                br=$(char_at $r2 $c2)

                # must be corners
                is_corner "$bl" && is_corner "$br" || continue

                # check vertical edges on both sides
                valid_sides=true

                for (( rr=r1+1; rr<r2; rr++ )); do
                    left=$(char_at $rr $c1)
                    right=$(char_at $rr $c2)
                    is_vline "$left" && is_vline "$right" || {
                        valid_sides=false
                        break
                    }
                done
                $valid_sides || continue

                # check bottom edge
                valid_bottom=true
                for (( c=c1+1; c<c2; c++ )); do
                    b=$(char_at $r2 $c)
                    if ! is_hline "$b"; then
                        valid_bottom=false
                        break
                    fi
                done
                $valid_bottom || continue

                # If all checks pass → rectangle found
                (( count++ ))
            done
        done
    done
done

echo "$count"
