#!/usr/bin/env bash
set -euo pipefail

# modular exponentiation using bc
modexp() {
    local base=$1
    local exp=$2
    local mod=$3
    echo "$base ^ $exp % $mod" | bc
}

main() {
    local cmd=$1
    shift

    case "$cmd" in
        privateKey)
            local p=$1
            # output a random integer: 2 <= x < p
            # use /dev/urandom to get a big random number
            local rand
            rand=$(od -An -N4 -tu4 < /dev/urandom | tr -d ' ')
            echo $(( (rand % (p - 2)) + 2 ))
            ;;

        publicKey)
            local p=$1 g=$2 private=$3
            modexp "$g" "$private" "$p"
            ;;

        secret)
            local p=$1 otherPublic=$2 private=$3
            modexp "$otherPublic" "$private" "$p"
            ;;

        *)
            echo "unknown command" >&2
            exit 1
            ;;
    esac
}

main "$@"
