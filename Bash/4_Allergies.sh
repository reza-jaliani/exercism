#!/usr/bin/env bash
set -euo pipefail

declare -A allergies=(
  [eggs]=1
  [peanuts]=2
  [shellfish]=4
  [strawberries]=8
  [tomatoes]=16
  [chocolate]=32
  [pollen]=64
  [cats]=128
)

score=${1:-0}
command=${2:-}
item=${3:-}

if [[ "$command" == "allergic_to" ]]; then
  value=${allergies[$item]:-0}
  if (( score & value )); then
    echo "true"
  else
    echo "false"
  fi
  exit 0
fi

if [[ "$command" == "list" ]]; then
  result=()
  for allergen in eggs peanuts shellfish strawberries tomatoes chocolate pollen cats; do
    value=${allergies[$allergen]}
    if (( score & value )); then
      result+=("$allergen")
    fi
  done
  # join the array elements with space
  echo "${result[*]}"
  exit 0
fi
