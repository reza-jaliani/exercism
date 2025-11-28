#!/usr/bin/env bash
set -euo pipefail

pre_str="${1:-}"
in_str="${2:-}"

read -r -a PRE <<< "$pre_str"
read -r -a IN  <<< "$in_str"

if [[ ${#PRE[@]} -ne ${#IN[@]} ]]; then
    echo "traversals must have the same length"
    exit 1
fi

sorted_pre=$(printf "%s\n" "${PRE[@]}" | sort)
sorted_in=$(printf "%s\n" "${IN[@]}" | sort)
if [[ "$sorted_pre" != "$sorted_in" ]]; then
    echo "traversals must have the same elements"
    exit 1
fi

if printf "%s\n" "${PRE[@]}" | sort | uniq -d | grep . >/dev/null; then
    echo "traversals must contain unique elements"
    exit 1
fi

build_tree() {
    local -n preorder=$1
    local -n inorder=$2

    local n=${#preorder[@]}
    if (( n == 0 )); then
        printf "{}"
        return
    fi
    local root="${preorder[0]}"
    local idx=-1
    for i in "${!inorder[@]}"; do
        if [[ "${inorder[$i]}" == "$root" ]]; then
            idx=$i
            break
        fi
    done
    local left_in=( "${inorder[@]:0:idx}" )
    local right_in=( "${inorder[@]:idx+1}" )
    local left_pre=( "${preorder[@]:1:${#left_in[@]}}" )
    local right_pre=( "${preorder[@]:1+${#left_in[@]}}" )
    local left_json
    local right_json
    left_json=$(build_tree left_pre left_in)
    right_json=$(build_tree right_pre right_in)

    printf '{"v": "%s", "l": %s, "r": %s}' "$root" "$left_json" "$right_json"
}

if (( ${#PRE[@]} == 0 )); then
    echo "{}"
else
    build_tree PRE IN
    echo
fi
