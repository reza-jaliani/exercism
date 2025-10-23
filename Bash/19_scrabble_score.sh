#!/usr/bin/env bash
main () {
    word=$(echo "${1^^}")
    score=0
    length=${#word}
    if [[ -z $word ]]; then
        echo "0" >&2
        exit 0
    fi
    for (( i=0; i<length; i++ )); do
        case ${word:i:1} in
            "A"|"E"|"I"|"O"|"U"|"L"|"N"|"R"|"S"|"T")
                (( score += 1 ))
                ;;
            "D"|"G")
                (( score += 2 ))
                ;;
            "B"|"C"|"M"|"P")
                (( score += 3 ))
                ;;
            "F"|"H"|"V"|"W"|"Y")
                (( score += 4 ))
                ;;
            "K")
                (( score += 5 ))
                ;;
            "J"|"X")
                (( score += 8 ))
                ;;
            "Q"|"Z")
                (( score += 10 ))
                ;;
            *)
                echo "Invalid character detected." >&2
                exit 1
                ;;
        esac
    done
    echo $score
}
main "$@"
