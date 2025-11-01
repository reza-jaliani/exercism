#!/usr/bin/env bash

main() {
  n=$1
  (( n < 2 )) && exit 0

  for ((i=2; i<=n; i++)); do
    sieve[i]=0
  done

  for ((p=2; p*p<=n; p++)); do
    if (( sieve[p] == 0 )); then
      for ((multiple=p*p; multiple<=n; multiple+=p)); do
        sieve[multiple]=1
      done
    fi
  done

  first=1
  for ((i=2; i<=n; i++)); do
    if (( sieve[i] == 0 )); then
      if (( first )); then
        printf "%d" "$i"
        first=0
      else
        printf " %d" "$i"
      fi
    fi
  done
  echo
}

main "$@"
