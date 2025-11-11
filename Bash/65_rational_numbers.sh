#!/usr/bin/env bash
set -euo pipefail

# Compute gcd(a, b)
gcd() {
    local a=$1 b=$2
    ((a < 0)) && a=$((-a))
    ((b < 0)) && b=$((-b))
    while (( b != 0 )); do
        local temp=$b
        b=$(( a % b ))
        a=$temp
    done
    echo "$a"
}

# Reduce fraction to lowest terms and normalize sign
reduce() {
    local frac=$1
    local num=${frac%%/*}
    local den=${frac##*/}

    # handle zero numerator
    if (( num == 0 )); then
        echo "0/1"
        return
    fi

    # ensure denominator positive
    if (( den < 0 )); then
        num=$((-num))
        den=$((-den))
    fi

    local g
    g=$(gcd "$num" "$den")
    num=$(( num / g ))
    den=$(( den / g ))

    echo "$num/$den"
}

# Parse a rational into num and den (by reference)
parse_rational() {
    local r=$1
    num=${r%%/*}
    den=${r##*/}
}

# Arithmetic operations
add() {
    parse_rational "$1"
    local a1=$num b1=$den
    parse_rational "$2"
    local a2=$num b2=$den
    local numr=$(( a1 * b2 + a2 * b1 ))
    local denr=$(( b1 * b2 ))
    reduce "$numr/$denr"
}

sub() {
    parse_rational "$1"
    local a1=$num b1=$den
    parse_rational "$2"
    local a2=$num b2=$den
    local numr=$(( a1 * b2 - a2 * b1 ))
    local denr=$(( b1 * b2 ))
    reduce "$numr/$denr"
}

mul() {
    parse_rational "$1"
    local a1=$num b1=$den
    parse_rational "$2"
    local a2=$num b2=$den
    local numr=$(( a1 * a2 ))
    local denr=$(( b1 * b2 ))
    reduce "$numr/$denr"
}

div() {
    parse_rational "$1"
    local a1=$num b1=$den
    parse_rational "$2"
    local a2=$num b2=$den
    local numr=$(( a1 * b2 ))
    local denr=$(( b1 * a2 ))
    reduce "$numr/$denr"
}

# Absolute value
abs() {
    parse_rational "$1"
    (( num < 0 )) && num=$((-num))
    (( den < 0 )) && den=$((-den))
    reduce "$num/$den"
}

# Integer exponentiation of a rational
pow() {
    local r=$1
    local n=$2
    parse_rational "$r"
    local a=$num b=$den
    if (( n == 0 )); then
        echo "1/1"
        return
    fi
    local absn=$(( n < 0 ? -n : n ))
    local anum=1 aden=1
    for ((i=0; i<absn; i++)); do
        anum=$(( anum * a ))
        aden=$(( aden * b ))
    done
    if (( n < 0 )); then
        # invert
        local tmp=$anum
        anum=$aden
        aden=$tmp
    fi
    reduce "$anum/$aden"
}

# Real number raised to a rational exponent
rpow() {
    local real=$1
    local frac=$2
    parse_rational "$frac"
    local a=$num b=$den

    # handle zero exponent explicitly
    if (( a == 0 )); then
        echo "1.0"
        return
    fi

    # real^(a/b) = e(l(real) * (a / b))
    local result
    result=$(echo "scale=8; e(l($real) * ($a / $b))" | bc -l)

    # Round to 6 decimals and format nicely
    result=$(printf "%.6f" "$result")
    result=$(echo "$result" | sed -E 's/0+$//; s/\.$/.0/')

    echo "$result"
}

main() {
    local op=$1
    case $op in
        +) add "$2" "$3" ;;
        -) sub "$2" "$3" ;;
        \*) mul "$2" "$3" ;;
        /) div "$2" "$3" ;;
        abs) abs "$2" ;;
        pow) pow "$2" "$3" ;;
        rpow) rpow "$2" "$3" ;;
        reduce) reduce "$2" ;;
        *) echo "Unknown operation: $op" >&2; exit 1 ;;
    esac
}

main "$@"
