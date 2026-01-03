NUMBERS = {
    10: "ten",
    9: "nine",
    8: "eight",
    7: "seven",
    6: "six",
    5: "five",
    4: "four",
    3: "three",
    2: "two",
    1: "one",
    0: "no",
}


def bottle_word(n):
    return "bottle" if n == 1 else "bottles"


def recite(start, take=1):
    result = []

    for current in range(start, start - take, -1):
        next_count = current - 1

        result.append(
            f"{NUMBERS[current]} green {bottle_word(current)} hanging on the wall,".capitalize()
        )
        result.append(
            f"{NUMBERS[current]} green {bottle_word(current)} hanging on the wall,".capitalize()
        )
        result.append(
            "And if one green bottle should accidentally fall,"
        )
        result.append(
            f"There'll be {NUMBERS[next_count]} green {bottle_word(next_count)} hanging on the wall."
        )

        if current != start - take + 1:
            result.append("")

    return result
