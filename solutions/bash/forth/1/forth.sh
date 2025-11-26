#!/usr/bin/env bash

fail() {
  echo "$1" >&2
  exit 1
}

stack=()
sp=0
popped=

check2args() {
  if ((sp == 0)); then
    fail "empty stack"
  elif ((sp == 1)); then
    fail "only one value on the stack"
  fi
}

pop() {
  ((sp != 0)) || fail "empty stack"
  ((--sp))
  popped="${stack[sp]}"
}

push() {
  stack[sp]="$1"
  ((++sp))
}

declare -A primitive=(
  ["+"]='{ check2args; pop; x="$popped"; pop; push $((popped + x)); }'
  ["-"]='{ check2args; pop; x="$popped"; pop; push $((popped - x)); }'
  ["*"]='{ check2args; pop; x="$popped"; pop; push $((popped * x)); }'
  ["/"]='{
     check2args; pop; x="$popped";
     ((x != 0)) || fail "divide by zero";
     pop; push $((popped / x)); }'
  ["dup"]='{ pop; push "$popped"; push "$popped"; }'
  ["drop"]='{ pop; }'
  ["swap"]='{ check2args; pop; x="$popped"; pop; push "$x"; push "$popped"; }'
  ["over"]='{ check2args; pop; x="$popped"; pop; push "$popped"; push "$x"; push "$popped"; }'
)

declare -A dict
definition=()

openword=
opendef=()

state="executing"

execute() {
  local def i op data
  read -ra def <<< "${definition[$1]}"
  for ((i = 0; i != ${#def[@]}; i += 2)); do
    op="${def[i]}"
    data="${def[i + 1]}"
    case "$op" in
    literal) use_number "$data" ;;
    word) use_word "$data" ;;
    primitive) use_primitive "$data" ;;
    esac
  done
}

number() {
  [[ "$1" =~ ^-?[0-9]+$ ]]
}

use_number() {
  case "$state" in
  executing) push "$1" ;;
  defining) opendef+=("literal $1") ;;
  *) fail "illegal operation" ;;
  esac
}

use_word() {
  case "$state" in
  executing) execute "$1" ;;
  defining) opendef+=("word $1") ;;
  *) fail "impossible call to use_word" ;;
  esac
}

use_primitive() {
  case "$state" in
  executing) eval "${primitive[$1]}" ;;
  defining) opendef+=("primitive $1") ;;
  *) fail "impossible call to use_primitive" ;;
  esac
}

while IFS= read -r line; do
  read -ra words <<< $(echo "$line" | tr "[:upper:]" "[:lower:]")
  for w in "${words[@]}"; do
    if number "$w"; then
      use_number "$w"
    elif [[ "$w" == ":" ]]; then
      [[ "$state" == "executing" ]] || fail "nested macro definition"
      state="start_def"
    elif [[ "$w" == ";" ]]; then
      [[ "$state" == "defining" ]] || fail "semicolon outside definition"
      ((${#opendef[@]} != 0)) || fail "empty macro definition"
      n=${#definition[@]}
      definition[n]="${opendef[*]}"
      dict[$openword]=$n
      opendef=()
      state="executing"
    elif [[ "$state" == "start_def" ]]; then
      ! number "$w" || fail "illegal operation"
      openword="$w"
      state="defining"
    elif [[ -n "${dict[$w]}" ]]; then
      use_word "${dict[$w]}"
    elif [[ -n "${primitive[$w]}" ]]; then
      use_primitive "$w"
    else
        fail "undefined operation"
    fi
  done
  [[ "$state" == "executing" ]] || fail "macro not terminated with semicolon"
done

stack=( "${stack[@]:0:sp}" )
echo "${stack[*]}"