# constants expected by the tests
EQUAL = "equal"
SUBLIST = "sublist"
SUPERLIST = "superlist"
UNEQUAL = "unequal"


def is_sublist(small, big):
    if not small:
        return True

    n = len(small)
    for i in range(len(big) - n + 1):
        if big[i:i + n] == small:
            return True

    return False


def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL

    if is_sublist(list_one, list_two):
        return SUBLIST

    if is_sublist(list_two, list_one):
        return SUPERLIST

    return UNEQUAL
