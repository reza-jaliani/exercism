#!/usr/bin/env bash
read -p "Enter your string: " myString
reverseString=""
for i in $myString; do
    reverseString="$i $reverseString"
done
echo $reverseString