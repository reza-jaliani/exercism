from collections import Counter

YACHT = 0
ONES = 1
TWOS = 2
THREES = 3
FOURS = 4
FIVES = 5
SIXES = 6
FULL_HOUSE = 7
FOUR_OF_A_KIND = 8
LITTLE_STRAIGHT = 9
BIG_STRAIGHT = 10
CHOICE = 11


def score(dice, category):
    counts = Counter(dice)

    if category == YACHT:
        return 50 if len(counts) == 1 else 0

    if category in (ONES, TWOS, THREES, FOURS, FIVES, SIXES):
        face = category
        return face * counts.get(face, 0)

    if category == FULL_HOUSE:
        if sorted(counts.values()) == [2, 3]:
            return sum(dice)
        return 0

    if category == FOUR_OF_A_KIND:
        for value, count in counts.items():
            if count >= 4:
                return value * 4
        return 0

    if category == LITTLE_STRAIGHT:
        return 30 if set(dice) == {1, 2, 3, 4, 5} else 0

    if category == BIG_STRAIGHT:
        return 30 if set(dice) == {2, 3, 4, 5, 6} else 0

    if category == CHOICE:
        return sum(dice)

    return 0
