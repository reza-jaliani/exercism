#!/usr/bin/env bash

main() {
  local mode="$1"
  local input="$2"

  case "$mode" in
    encode)
      encode "$input"
      ;;
    decode)
      decode "$input"
      ;;
    *)
      echo "Invalid mode. Use 'encode' or 'decode'." >&2
      exit 1
      ;;
  esac
}

encode() {
  local str="$1"
  local prev=""
  local count=0
  local result=""

  # read character by character
  while IFS= read -r -n1 char; do
    if [[ "$char" == "$prev" ]]; then
      ((count++))
    else
      if ((count > 1)); then
        result+="${count}${prev}"
      elif ((count == 1)); then
        result+="${prev}"
      fi
      prev="$char"
      count=1
    fi
  done <<< "$str"

  # handle last run
  if ((count > 1)); then
    result+="${count}${prev}"
  elif ((count == 1)); then
    result+="${prev}"
  fi

  echo "$result"
}

decode() {
  local str="$1"
  local result=""
  local num=""
  local char

  while IFS= read -r -n1 char; do
    if [[ "$char" =~ [0-9] ]]; then
      num+="$char"
    else
      if [[ -n "$num" ]]; then
        result+=$(printf "%0.s$char" $(seq 1 "$num"))
        num=""
      else
        result+="$char"
      fi
    fi
  done <<< "$str"

  echo "$result"
}

main "$@"
