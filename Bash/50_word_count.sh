#!/usr/bin/env bash
set -euo pipefail

input="$*"

if [[ ${#input} -ge 2 ]]; then
    first=${input:0:1}
    last=${input: -1}
    if [[ ( "$first" == "'" && "$last" == "'" ) || ( "$first" == '"' && "$last" == '"' ) ]]; then
        input=${input:1:${#input}-2}
    fi
fi

# 3) Lowercase the text to make counting case-insensitive
text=$(printf "%s" "$input" | tr '[:upper:]' '[:lower:]')

words=$(printf "%s" "$text" | grep -oE "[a-z0-9]+('[a-z0-9]+)*" || true)

[ -z "$words" ] && exit 0

printf "%s\n" "$words" \
    | sort \
    | uniq -c \
    | awk '{print $2 ": " $1}'
