"""Functions to manage a users shopping cart items."""


def add_item(current_cart, items_to_add):
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    cart = current_cart.copy()
    for item in items_to_add:
        cart[item] = cart.setdefault(item, 0) + 1
    return cart


def read_notes(notes):
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    return {item: 1 for item in notes}


def update_recipes(ideas, recipe_updates):
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: iterable -  with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    return ideas | dict(recipe_updates)


def sort_entries(cart):
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


def send_to_store(cart, aisle_mapping):
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    fulfillment = {}
    for item, qty in cart.items():
        aisle, cold = aisle_mapping[item]
        fulfillment[item] = [qty, aisle, cold]
    return dict(sorted(fulfillment.items(), reverse=True))

def update_store_inventory(fulfillment_cart, store_inventory):
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """
    updated = {}

    for item, (qty, aisle, cold) in store_inventory.items():
        if item in fulfillment_cart:
            ordered_qty = fulfillment_cart[item][0]
            new_qty = qty - ordered_qty
            if new_qty <= 0:
                updated[item] = ["Out of Stock", aisle, cold]
            else:
                updated[item] = [new_qty, aisle, cold]
        else:
            updated[item] = [qty, aisle, cold]

    return updated