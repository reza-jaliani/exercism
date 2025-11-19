#!/usr/bin/env bash
set -euo pipefail

year=$1
month=$2
week=$3
weekday=$4

# Map weekday names to numbers used by date +%u (1=Mon ... 7=Sun)
declare -A wdmap=(
  [Monday]=1 [Tuesday]=2 [Wednesday]=3 [Thursday]=4
  [Friday]=5 [Saturday]=6 [Sunday]=7
)

target_wd=${wdmap[$weekday]}

# Helper to get weekday of a specific day
get_wd() {
    date -d "$year-$month-$1" +%u
}

# Helper to get last day of month
last_day_of_month() {
    date -d "$year-$month-01 +1 month -1 day" +%d
}

case $week in
  teenth)
      for d in {13..19}; do
          if [[ $(get_wd "$d") -eq $target_wd ]]; then
              printf "%04d-%02d-%02d\n" "$year" "$month" "$d"
              exit 0
          fi
      done
      ;;

  first|second|third|fourth)
      # Convert week name to index (0,1,2,3)
      declare -A windex=([first]=0 [second]=1 [third]=2 [fourth]=3)
      idx=${windex[$week]}

      # Find first matching weekday
      for d in {1..7}; do
          if [[ $(get_wd "$d") -eq $target_wd ]]; then
              day=$(( d + idx*7 ))
              printf "%04d-%02d-%02d\n" "$year" "$month" "$day"
              exit 0
          fi
      done
      ;;

  last)
      last=$(last_day_of_month)

      for ((d=last; d>=last-6; d--)); do
          if [[ $(get_wd "$d") -eq $target_wd ]]; then
              printf "%04d-%02d-%02d\n" "$year" "$month" "$d"
              exit 0
          fi
      done
      ;;

  *)
      echo "Invalid week descriptor"
      exit 1
      ;;
esac
