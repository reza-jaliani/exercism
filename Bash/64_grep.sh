#!/usr/bin/env bash

# Initialize flags
flag_n=false
flag_l=false
flag_i=false
flag_v=false
flag_x=false

# Parse flags
while getopts "nlivx" opt; do
    case $opt in
        n) flag_n=true ;;
        l) flag_l=true ;;
        i) flag_i=true ;;
        v) flag_v=true ;;
        x) flag_x=true ;;
        *) echo "Unknown option"; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

# Validate args
if (( $# < 2 )); then
    echo "Usage: $0 [-n] [-l] [-i] [-v] [-x] pattern file..."
    exit 1
fi

pattern=$1
shift
files=("$@")

# Case-insensitive matching
if $flag_i; then
    shopt -s nocasematch
fi

# --- Function to check if line matches ---
match_line() {
    local line=$1
    local matched=false

    if $flag_x; then
        [[ $line =~ ^$pattern$ ]] && matched=true
    else
        [[ $line =~ $pattern ]] && matched=true
    fi

    if $flag_v; then
        if $matched; then
            matched=false
        else
            matched=true
        fi
    fi

    $matched
}

matched_files=()

for file in "${files[@]}"; do
    file_has_match=false
    line_number=0

    while IFS='' read -r line || [[ -n $line ]]; do
        ((line_number++))
        if match_line "$line"; then
            file_has_match=true
            if ! $flag_l; then
                output=""
                if (( ${#files[@]} > 1 )); then
                    output+="$file:"
                fi
                if $flag_n; then
                    output+="$line_number:"
                fi
                output+="$line"
                echo "$output"
            fi
        fi
    done < "$file"

    if $flag_l && $file_has_match; then
        matched_files+=("$file")
    fi
done

if $flag_l && ((${#matched_files[@]} > 0)); then
    printf "%s\n" "${matched_files[@]}"
fi
