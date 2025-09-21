#!/usr/bin/env bash
funcReverser () {
    local strMyString="$1"
    local strReverseString=""
    local intLength=${#strMyString}
    for ((i=intLength-1; i>=0; i--)); do
        strReverseString="${strReverseString}${strMyString:$i:1}"
    done
    echo "$strReverseString"
}
main() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <string>"
        exit 1
    fi
    result=""
    result=$(funcReverser "$1")
    echo "$result"
}
main "$@"