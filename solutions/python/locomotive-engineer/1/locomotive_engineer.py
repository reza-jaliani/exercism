"""Functions which helps the locomotive engineer to keep track of the train."""


def get_list_of_wagons(*wagon_ids):
    """Return a list of wagons.

    :param: arbitrary number of wagons.
    :return: list - list of wagons.
    """
    return [*wagon_ids]


def fix_list_of_wagons(each_wagons_id, missing_wagons):
    """Fix the list of wagons.

    :param each_wagons_id: list - the list of wagons.
    :param missing_wagons: list - the list of missing wagons.
    :return: list - list of wagons.
    """
    #---------Dispatch the two first wagons
    a, b, *rest = each_wagons_id

    #---------Find the locomotive ID
    loco_index = rest.index(1)

    #---------Make the new list
    before = rest[:loco_index + 1]
    after = rest[loco_index + 1:]

    #Build the final list
    return [*before, *missing_wagons, *after, a, b]


def add_missing_stops(route, **stops):
    """Add missing stops to route dict.

    :param route: dict - the dict of routing information.
    :param: arbitrary number of stops.
    :return: dict - updated route dictionary.
    """
    route["stops"] = [*stops.values()]
    return route


def extend_route_information(route, more_route_information):
    """Extend route information with more_route_information.

    :param route: dict - the route information.
    :param more_route_information: dict -  extra route information.
    :return: dict - extended route information.
    """
    return {**route, **more_route_information}


def fix_wagon_depot(wagons_rows):
    """Fix the list of rows of wagons.

    :param wagons_rows: list[list[tuple]] - the list of rows of wagons.
    :return: list[list[tuple]] - list of rows of wagons.
    """
    row1, row2, row3 = wagons_rows

    col1 = (row1[0], row2[0], row3[0])
    col2 = (row1[1], row2[1], row3[1])
    col3 = (row1[2], row2[2], row3[2])
    return [
        [*col1],
        [*col2],
        [*col3],
    ]
