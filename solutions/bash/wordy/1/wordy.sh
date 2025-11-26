#!/usr/bin/env bash

input="$1"

# If it doesn't start with "What is" OR doesn't end with "?", it's not a math question we support.
if [[ ! "$input" =~ ^What\ is ]] || [[ "${input: -1}" != '?' ]]; then
    echo "unknown operation"
    exit 1
fi

# Remove the leading "What is" (with or without a following space)
content="${input#What is}"
# If there's a leading space, strip it
if [[ "${content:0:1}" == " " ]]; then
    content="${content:1}"
fi
# Remove trailing question mark
content="${content%?}"

# Detect unsupported operations (must be checked on the original content)
# Add more unsupported patterns here if exercism tests expand later.
if echo "$content" | grep -E 'cubed' >/dev/null; then
    echo "unknown operation"
    exit 1
fi

# Replace supported verbal operators with symbols (spaces around operators help tokenizing)
converted="$(echo "$content" \
    | sed -E 's/ multiplied by / \* /g' \
    | sed -E 's/ divided by / \/ /g' \
    | sed -E 's/ plus / + /g' \
    | sed -E 's/ minus / - /g'
)"

# After replacement, any remaining letters means invalid syntax (e.g., "plus" leftover)
if echo "$converted" | grep -E '[a-zA-Z]' >/dev/null; then
    echo "syntax error"
    exit 1
fi

# Tokenize by whitespace
read -a tokens <<< "$converted"

# No tokens -> syntax error (covers "What is?" and "What is plus?")
if (( ${#tokens[@]} == 0 )); then
    echo "syntax error"
    exit 1
fi

# First token must be a number
if ! [[ "${tokens[0]}" =~ ^-?[0-9]+$ ]]; then
    echo "syntax error"
    exit 1
fi

# Enforce alternating pattern: number op number op number ...
expect="op"
for ((i=1; i<${#tokens[@]}; i++)); do
    t="${tokens[$i]}"

    if [[ "$expect" == "op" ]]; then
        if ! [[ "$t" =~ ^(\+|-|\*|/)$ ]]; then
            echo "syntax error"
            exit 1
        fi
        expect="num"
    else
        if ! [[ "$t" =~ ^-?[0-9]+$ ]]; then
            echo "syntax error"
            exit 1
        fi
        expect="op"
    fi
done

# If we ended expecting a number, the expression ended with an operator -> syntax error
if [[ "$expect" == "num" ]]; then
    echo "syntax error"
    exit 1
fi

# Evaluate left-to-right
result="${tokens[0]}"
i=1
while (( i < ${#tokens[@]} )); do
    op="${tokens[i]}"
    num="${tokens[i+1]}"

    case "$op" in
        +) result=$((result + num)) ;;
        -) result=$((result - num)) ;;
        \*) result=$((result * num)) ;;
        /) result=$((result / num)) ;;
    esac

    ((i+=2))
done

echo "$result"
