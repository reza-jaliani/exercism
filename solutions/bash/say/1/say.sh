#!/usr/bin/env bash

# Converts numbers (0–999,999,999,999) into English words

small=(
  zero one two three four five six seven eight nine
  ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen
)

tens=(
  "" "" twenty thirty forty fifty sixty seventy eighty ninety
)

# Convert a number from 0–999 into English
say_hundreds() {
  local n=$1
  local words=""

  if (( n >= 100 )); then
    local hundreds=$(( n / 100 ))
    words+="${small[$hundreds]} hundred"
    n=$(( n % 100 ))
    (( n > 0 )) && words+=" "
  fi

  if (( n >= 20 )); then
    local t=$(( n / 10 ))
    local ones=$(( n % 10 ))
    words+="${tens[$t]}"
    (( ones > 0 )) && words+="-${small[$ones]}"
  elif (( n > 0 )); then
    words+="${small[$n]}"
  elif [[ -z "$words" ]]; then
    words+="zero"
  fi

  echo "$words"
}

main() {
  local num="$1"

  # Range check
  if (( num < 0 || num > 999999999999 )); then
    echo "input out of range"
    exit 1
  fi

  # Special case: 0
  if (( num == 0 )); then
    echo "zero"
    exit 0
  fi

  local billions=$(( num / 1000000000 ))
  local millions=$(( (num / 1000000) % 1000 ))
  local thousands=$(( (num / 1000) % 1000 ))
  local ones=$(( num % 1000 ))

  local parts=()

  (( billions > 0 )) && parts+=("$(say_hundreds $billions) billion")
  (( millions > 0 )) && parts+=("$(say_hundreds $millions) million")
  (( thousands > 0 )) && parts+=("$(say_hundreds $thousands) thousand")
  (( ones > 0 )) && parts+=("$(say_hundreds $ones)")

  local result="${parts[*]}"
  echo "$result"
}

main "$@"
