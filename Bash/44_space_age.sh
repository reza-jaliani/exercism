#!/usr/bin/env bash

main() {
    planet=${1:-}
    age_in_sec=${2:-0}
    earth_year_sec=31557600

    case "$planet" in
        "Mercury")
            orbital_period=0.2408467
            ;;
        "Venus")
            orbital_period=0.61519726
            ;;
        "Earth")
            orbital_period=1.0
            ;;
        "Mars")
            orbital_period=1.8808158
            ;;
        "Jupiter")
            orbital_period=11.862615
            ;;
        "Saturn")
            orbital_period=29.447498
            ;;
        "Uranus")
            orbital_period=84.016846
            ;;
        "Neptune")
            orbital_period=164.79132
            ;;
        *)
            echo "not a planet"
            exit 1
            ;;
    esac

    # calculate age on the planet
    age=$(awk -v sec="$age_in_sec" -v period="$orbital_period" -v earth="$earth_year_sec" \
        'BEGIN { printf "%.2f", sec / (earth * period) }')

    echo "$age"
}

main "$@"
