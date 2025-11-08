#!/usr/bin/env bash
set -euo pipefail

main() {
    map_plant() {
        case "$1" in
            G) echo -n "grass" ;;
            C) echo -n "clover" ;;
            R) echo -n "radishes" ;;
            V) echo -n "violets" ;;
            *) echo -n "unknown" ;;
        esac
    }

    students=(Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry)

    garden="${1:-}"
    student="${2:-}"

    # find student index
    student_index=-1
    for i in "${!students[@]}"; do
        [[ "${students[$i]}" == "$student" ]] && student_index="$i" && break
    done

    (( student_index >= 0 )) || { echo "Unknown child: $student" >&2; exit 1; }

    # --- FIX: Read the two lines safely ---
    mapfile -t rows < <(printf "%s\n" "$garden")
    row1="${rows[0]}"
    row2="${rows[1]}"

    start=$(( student_index * 2 ))

    part1="${row1:start:2}"
    part2="${row2:start:2}"

    a=$(map_plant "${part1:0:1}")
    b=$(map_plant "${part1:1:1}")
    c=$(map_plant "${part2:0:1}")
    d=$(map_plant "${part2:1:1}")

    printf "%s %s %s %s\n" "$a" "$b" "$c" "$d"
}

main "$@"
