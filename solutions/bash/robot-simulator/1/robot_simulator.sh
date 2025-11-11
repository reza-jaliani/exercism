#!/usr/bin/env bash
set -u  # keep strict undefined variable checks, but drop -e so arithmetic works fine

main() {
    # Default values
    local x=${1:-0}
    local y=${2:-0}
    local dir=${3:-north}
    local instructions=${4:-}

    # Validate direction
    case $dir in
        north|east|south|west) ;;
        *)
            echo "invalid direction" >&2
            exit 1
            ;;
    esac

    # Rotation order
    local dirs=("north" "east" "south" "west")

    turn_right() {
        local i
        for i in "${!dirs[@]}"; do
            if [[ "${dirs[$i]}" == "$dir" ]]; then
                dir=${dirs[$(( (i + 1) % 4 ))]}
                return
            fi
        done
    }

    turn_left() {
        local i
        for i in "${!dirs[@]}"; do
            if [[ "${dirs[$i]}" == "$dir" ]]; then
                dir=${dirs[$(( (i + 3) % 4 ))]}
                return
            fi
        done
    }

    advance() {
        case $dir in
            north) y=$((y + 1)) ;;
            south) y=$((y - 1)) ;;
            east)  x=$((x + 1)) ;;
            west)  x=$((x - 1)) ;;
        esac
    }

    # Process each instruction
    if [[ -n "$instructions" ]]; then
        local i ch
        for ((i=0; i<${#instructions}; i++)); do
            ch=${instructions:i:1}
            case $ch in
                R) turn_right ;;
                L) turn_left ;;
                A) advance ;;
                *)
                    echo "invalid instruction" >&2
                    exit 1
                    ;;
            esac
        done
    fi

    echo "$x $y $dir"
}

main "$@"
