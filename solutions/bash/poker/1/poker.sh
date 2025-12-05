#!/usr/bin/env bash
# poker.sh — picks best poker hand(s) from args
# Output: only winning hand(s), one per line (no debug)

value() {
    case "$1" in
        2) echo 2 ;; 3) echo 3 ;; 4) echo 4 ;; 5) echo 5 ;;
        6) echo 6 ;; 7) echo 7 ;; 8) echo 8 ;; 9) echo 9 ;;
        10) echo 10 ;; J) echo 11 ;; Q) echo 12 ;; K) echo 13 ;; A) echo 14 ;;
    esac
}

evaluate() {
    local hand="$1"
    local cards=($hand)
    local ranks=() suits=()

    for c in "${cards[@]}"; do
        local r="${c::-1}"
        local s="${c: -1}"
        ranks+=( "$(value "$r")" )
        suits+=( "$s" )
    done

    # sort ascending numeric for detecting straights (and wheel)
    IFS=$'\n' ranks_sorted=($(sort -n <<<"${ranks[*]}"))
    unset IFS

    # detect wheel A-2-3-4-5
    local is_wheel=0
    if [[ "${ranks_sorted[*]}" == "2 3 4 5 14" ]]; then
        is_wheel=1
        # represent wheel as 1..5 for straight detection/ordering
        ranks_sorted=(1 2 3 4 5)
    fi

    # counts
    declare -A cnt
    for r in "${ranks_sorted[@]}"; do
        ((cnt[$r]++))
    done

    # build groups "freq:rank" for sorting by freq desc then rank desc
    groups=()
    for r in "${!cnt[@]}"; do
        groups+=( "${cnt[$r]}:$r" )
    done
    IFS=$'\n' groups_sorted=($(sort -t: -k1,1nr -k2,2nr <<<"${groups[*]}"))
    unset IFS

    # detect flush (use original suits)
    flush=1
    for s in "${suits[@]}"; do [[ $s != "${suits[0]}" ]] && flush=0; done

    # detect straight (on ranks_sorted which already handles wheel)
    straight=1
    for i in 0 1 2 3; do
        local a=${ranks_sorted[i]}
        local b=${ranks_sorted[i+1]}
        if (( b != a + 1 )); then straight=0; break; fi
    done

    # pull primary freq info
    local freq1=${groups_sorted[0]%%:*}
    local rank1=${groups_sorted[0]##*:}
    local freq2=0; local rank2=0
    if [[ ${#groups_sorted[@]} -gt 1 ]]; then
        freq2=${groups_sorted[1]%%:*}
        rank2=${groups_sorted[1]##*:}
    fi

    # determine strength
    local strength
    if (( straight && flush )); then
        strength=8
    elif (( freq1 == 4 )); then
        strength=7
    elif (( freq1 == 3 && freq2 == 2 )); then
        strength=6
    elif (( flush )); then
        strength=5
    elif (( straight )); then
        strength=4
    elif (( freq1 == 3 )); then
        strength=3
    elif (( freq1 == 2 && freq2 == 2 )); then
        strength=2
    elif (( freq1 == 2 )); then
        strength=1
    else
        strength=0
    fi

    # Build kicker list in correct comparison order
    kickers=()
    if (( strength == 4 || strength == 8 )); then
        # Straight or Straight-Flush: only highest card matters
        # ranks_sorted is ascending; highest = last
        local high=${ranks_sorted[${#ranks_sorted[@]}-1]}
        kickers+=( "$high" )
    elif (( strength == 5 || strength == 0 )); then
        # Flush or High-card: compare full 5 cards descending (use original ranks with Ace=14)
        IFS=$'\n' tmp=($(sort -nr <<<"${ranks[*]}"))
        unset IFS
        kickers=("${tmp[@]}")
    else
        # pairs/trips/quads/full-house: groups_sorted already ordered by freq desc then rank desc
        for g in "${groups_sorted[@]}"; do
            local f=${g%%:*}
            local rv=${g##*:}
            for ((i=0; i<f; i++)); do kickers+=( "$rv" ); done
        done
    fi

    # Format output: strength then zero-padded kickers so lexical compare == numeric compare
    out=$(printf "%d" "$strength")
    for k in "${kickers[@]}"; do
        out+=" $(printf "%02d" "$k")"
    done

    echo "$out"
}

##### MAIN #####
best=""
declare -a winners=()

for hand in "$@"; do
    score=$(evaluate "$hand")
    if [[ -z "$best" ]] || [[ "$score" > "$best" ]]; then
        best="$score"
        winners=("$hand")
    elif [[ "$score" == "$best" ]]; then
        winners+=("$hand")
    fi
done

printf "%s\n" "${winners[@]}"
