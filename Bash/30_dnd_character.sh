#!/usr/bin/env bash
if [[ $1 == "modifier" ]]; then
    constitution=$2
    modifier=$(( (constitution - 10) / 2 ))
    if (( (constitution - 10) < 0 && (constitution - 10) % 2 != 0 )); then
        ((modifier--))
    fi
    echo "$modifier"
    exit 0
fi
if [[ $1 == "generate" ]]; then
    roll_dice() {
        for _ in {1..4}; do
            echo $((RANDOM % 6 + 1))
        done
    }
    ability_score() {
        rolls=($(roll_dice | sort -nr))
        echo $((rolls[0] + rolls[1] + rolls[2]))
    }
    strength=$(ability_score)
    dexterity=$(ability_score)
    constitution=$(ability_score)
    intelligence=$(ability_score)
    wisdom=$(ability_score)
    charisma=$(ability_score)
    constitution_modifier=$(( (constitution - 10) / 2 ))
    if (( (constitution - 10) < 0 && (constitution - 10) % 2 != 0 )); then
        ((constitution_modifier--))
    fi
    hitpoints=$((10 + constitution_modifier))
    echo "strength $strength"
    echo "dexterity $dexterity"
    echo "constitution $constitution"
    echo "intelligence $intelligence"
    echo "wisdom $wisdom"
    echo "charisma $charisma"
    echo "hitpoints $hitpoints"
    exit 0
fi
