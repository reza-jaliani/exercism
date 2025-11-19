"""Functions for tracking poker hands and assorted card tasks."""

def get_rounds(number):
    """Create a list containing the current and next two round numbers."""

    return [number, number + 1, number + 2 ]


def concatenate_rounds(rounds_1, rounds_2):
    """Concatenate two lists of round numbers."""

    return rounds_1 + rounds_2


def list_contains_round(rounds, number):
    """Check if the list of rounds contains the specified number."""

    return number in rounds


def card_average(hand):
    """Calculate and returns the average card value from the list."""

    return sum(hand) / len(hand)


def approx_average_is_average(hand):
    """Return if the (average of first and last card values) OR ('middle' card) == calculated average."""

    actual_avg = sum(hand) / len(hand)
    
    first_last_avg = (hand[0] + hand[-1]) / 2
    middle_value = hand[len(hand) // 2]
    
    return first_last_avg == actual_avg or middle_value == actual_avg


def average_even_is_average_odd(hand):
    """Return if the (average of even indexed card values) == (average of odd indexed card values)."""

    even_positions = hand[0::2]
    odd_positions = hand[1::2]
    
    return sum(even_positions) / len(even_positions) == \
           sum(odd_positions) / len(odd_positions)


def maybe_double_last(hand):
    """Multiply a Jack card value in the last index position by 2."""

    if hand[-1] == 11:
        hand[-1] = 22
    return hand
