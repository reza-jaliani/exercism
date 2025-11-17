"""Functions to help play and score a game of blackjack."""

def value_of_card(card):
    """Determine the scoring value of a card."""

    if card in ['J', 'Q', 'K']:
        return 10
    elif card is 'A':
        return 1
    else:
        return int(card)
    


def higher_card(card_one, card_two):
    """Determine which card has a higher value in the hand."""

    value_one = value_of_card(card_one)
    value_two = value_of_card(card_two)
    if value_one > value_two:
        return card_one
    elif value_two > value_one:
        return card_two
    else:
        return (card_one, card_two)


def value_of_ace(card_one, card_two):
    """Calculate the most advantageous value for the ace card."""

    value_one = value_of_card(card_one)
    if card_one is 'A':
        value_one = 11
    value_two = value_of_card(card_two)
    if card_two is 'A':
        value_two = 11
    total = value_one + value_two
    if total + 11 <= 21:
        return 11
    return 1

def is_blackjack(card_one, card_two):
    """Determine if the hand is a 'natural' or 'blackjack'."""

    value_one = value_of_card(card_one)
    if card_one is 'A':
        value_one = 11
    value_two = value_of_card(card_two)
    if card_two is 'A':
        value_two = 11
    total = value_one + value_two
    return total == 21


def can_split_pairs(card_one, card_two):
    """Determine if a player can split their hand into two hands."""

    return value_of_card(card_one) == value_of_card(card_two)


def can_double_down(card_one, card_two):
    """Determine if a blackjack player can place a double down bet.

    :param card_one, card_two: str - first and second cards in hand.
    :return: bool - can the hand can be doubled down? (i.e. totals 9, 10 or 11 points).
    """

    value_one = value_of_card(card_one)
    value_two = value_of_card(card_two)
    total = value_one + value_two
    return total in [9, 10, 11]
