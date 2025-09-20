#!/usr/bin/env bash
read -p "Enter your string: " myString
reverseString=""
length=${#myString}
for ((i=$length-1; i>=0; i--)); do
    reverseString="${reverseString}${myString:$i:1}"
done
echo $reverseString