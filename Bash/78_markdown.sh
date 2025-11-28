#!/usr/bin/env bash
set -euo pipefail

input_file="$1"

inside_list="no"
output=""

format_inline() {
    local text="$1"

    text="$(sed -E 's/__([^_]+)__/<strong>\1<\/strong>/g' <<< "$text")"

    text="$(sed -E 's/_([^_]+)_/<em>\1<\/em>/g' <<< "$text")"

    printf "%s" "$text"
}

while IFS= read -r line; do


    if [[ "$line" =~ ^\* ]]; then
        if [[ "$inside_list" != "yes" ]]; then
            output+="<ul>"
            inside_list="yes"
        fi

        clean="${line#\* }"
        clean="$(format_inline "$clean")"
        output+="<li>$clean</li>"
        continue
    fi

    if [[ "$inside_list" == "yes" ]]; then
        output+="</ul>"
        inside_list="no"
    fi

    if [[ "$line" =~ ^(#{1,6})\ +(.*)$ ]]; then
        hashes="${BASH_REMATCH[1]}"
        content="${BASH_REMATCH[2]}"
        level="${#hashes}"

        content="$(format_inline "$content")"
        output+="<h$level>$content</h$level>"
        continue
    fi

    formatted="$(format_inline "$line")"
    output+="<p>$formatted</p>"

done < "$input_file"

# Close list if file ended inside one
if [[ "$inside_list" == "yes" ]]; then
    output+="</ul>"
fi

echo "$output"
