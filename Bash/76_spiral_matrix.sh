#!/usr/bin/env bash

n="$1"

# Handle n=0
if (( n == 0 )); then
    exit 0
fi

# Allocate flat array
size=$((n*n))
for ((i=0; i<size; i++)); do
    matrix[$i]=0
done

# Index function: idx = row*n + col
idx() {
    echo $(( $1 * n + $2 ))
}

top=0
bottom=$((n-1))
left=0
right=$((n-1))
num=1

while (( left <= right && top <= bottom )); do

    # ←→ (top row, left → right)
    for ((col=left; col<=right; col++)); do
        matrix[$(idx $top $col)]=$num
        ((num++))
    done
    ((top++))

    # ↓ (right column, top → bottom)
    for ((row=top; row<=bottom; row++)); do
        matrix[$(idx $row $right)]=$num
        ((num++))
    done
    ((right--))

    # →← (bottom row, right → left)
    if (( top <= bottom )); then
        for ((col=right; col>=left; col--)); do
            matrix[$(idx $bottom $col)]=$num
            ((num++))
        done
        ((bottom--))
    fi

    # ↑ (left column, bottom → top)
    if (( left <= right )); then
        for ((row=bottom; row>=top; row--)); do
            matrix[$(idx $row $left)]=$num
            ((num++))
        done
        ((left++))
    fi
done

# Print matrix
for ((i=0; i<n; i++)); do
    line=""
    for ((j=0; j<n; j++)); do
        val=${matrix[$(idx $i $j)]}
        if [[ $j -eq 0 ]]; then
            line="$val"
        else
            line="$line $val"
        fi
    done
    echo "$line"
done
