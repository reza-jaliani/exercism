#!/usr/bin/env bash

# Output header line
print_header() {
    printf "Team                           | MP |  W |  D |  L |  P\n"
}

# Ensure a team is present in the associative arrays
ensure_team() {
    local team="$1"
    if [[ -z "${MP[$team]+_}" ]]; then
        MP[$team]=0
        W[$team]=0
        D[$team]=0
        L[$team]=0
        P[$team]=0
    fi
}

# --- MAIN PROGRAM ---

# Read input either from file or stdin
if [[ -n "$1" ]]; then
    input=$(cat "$1")
else
    input=$(cat)
fi

declare -A MP W D L P

# If no matches, just print header
if [[ -z "$input" ]]; then
    print_header
    exit 0
fi

# Process each match line
while IFS=";" read -r team1 team2 result; do
    [[ -z "$team1" ]] && continue

    ensure_team "$team1"
    ensure_team "$team2"

    # Every match adds +1 MP
    (( MP[$team1]++ ))
    (( MP[$team2]++ ))

    case "$result" in
        win)
            (( W[$team1]++ ))
            (( L[$team2]++ ))
            (( P[$team1]+=3 ))
            ;;
        loss)
            (( W[$team2]++ ))
            (( L[$team1]++ ))
            (( P[$team2]+=3 ))
            ;;
        draw)
            (( D[$team1]++ ))
            (( D[$team2]++ ))
            (( P[$team1]++ ))
            (( P[$team2]++ ))
            ;;
    esac
done <<< "$input"

# Sort teams: by points desc, then name asc
sorted_teams=$(for t in "${!MP[@]}"; do
    echo "$t|${P[$t]}"
done | sort -t"|" -k2,2nr -k1,1)

# Print
print_header

while IFS="|" read -r name points; do
    printf "%-30s | %2d | %2d | %2d | %2d | %2d\n" \
        "$name" \
        "${MP[$name]}" \
        "${W[$name]}" \
        "${D[$name]}" \
        "${L[$name]}" \
        "${P[$name]}"
done <<< "$sorted_teams"
