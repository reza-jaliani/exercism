#!/usr/bin/env bash

# ---------- Argument parsing ----------
if [[ $# -lt 3 ]]; then
    echo "Usage: $0 -e|-d rails text" >&2
    exit 1
fi

mode="$1"
rails="$2"
text="$3"

# Rails must be positive
if ! [[ "$rails" =~ ^[0-9]+$ ]] || (( rails < 1 )); then
    echo "Rails must be a positive integer" >&2
    exit 1
fi

# If rails >= text length → no transformation
if (( rails >= ${#text} )); then
    echo "$text"
    exit 0
fi

# ---------- Encode ----------
encode() {
    local text="$1" rails="$2"
    local -a railbuf
    for ((i=0; i<rails; i++)); do railbuf[i]=""; done

    local r=0 step=1

    for ((i=0; i<${#text}; i++)); do
        railbuf[r]+="${text:i:1}"
        (( r += step ))
        if (( r == rails-1 || r == 0 )); then
            step=$(( -step ))
        fi
    done

    printf "%s" "${railbuf[@]}"
}

# ---------- Decode ----------
decode() {
    local text="$1" rails="$2"
    local len=${#text}

    # Step 1: mark zigzag pattern with row indices
    local -a pattern
    local r=0 step=1
    for ((i=0; i<len; i++)); do
        pattern[i]=$r
        (( r += step ))
        if (( r == rails-1 || r == 0 )); then
            step=$(( -step ))
        fi
    done

    # Step 2: count how many chars go in each rail
    local -a count
    for ((i=0; i<rails; i++)); do count[i]=0; done
    for ((i=0; i<len; i++)); do
        (( count[ pattern[i] ]++ ))
    done

    # Step 3: slice ciphertext into rail strings
    local -a rail
    local pos=0
    for ((r=0; r<rails; r++)); do
        rail[r]="${text:pos:count[r]}"
        (( pos += count[r] ))
    done

    # Step 4: reconstruct original by following pattern
    local -a rail_pos
    for ((i=0; i<rails; i++)); do rail_pos[i]=0; done

    local result=""
    for ((i=0; i<len; i++)); do
        local row=${pattern[i]}
        result+=${rail[row]:rail_pos[row]:1}
        (( rail_pos[row]++ ))
    done

    printf "%s" "$result"
}

# ---------- Main ----------
case "$mode" in
    -e) encode "$text" "$rails" ;;
    -d) decode "$text" "$rails" ;;
    *)
        echo "Unknown option: $mode" >&2
        exit 1
        ;;
esac
