def resistor_label(colors):
    color_values = {
        "black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
        "green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9
    }

    tolerance_values = {
        "grey": "0.05%", "violet": "0.1%", "blue": "0.25%",
        "green": "0.5%", "brown": "1%", "red": "2%",
        "gold": "5%", "silver": "10%"
    }

    # 1 band
    if len(colors) == 1:
        return "0 ohms"

    # 4 band
    if len(colors) == 4:
        d1 = color_values[colors[0]]
        d2 = color_values[colors[1]]
        multiplier = 10 ** color_values[colors[2]]
        tolerance = tolerance_values[colors[3]]
        value = (d1 * 10 + d2) * multiplier

    # 5 band
    if len(colors) == 5:
        d1 = color_values[colors[0]]
        d2 = color_values[colors[1]]
        d3 = color_values[colors[2]]
        multiplier = 10 ** color_values[colors[3]]
        tolerance = tolerance_values[colors[4]]
        value = (d1 * 100 + d2 * 10 + d3) * multiplier

    # naming the value
    if value >= 1_000_000:
        ohms = value / 1_000_000
        # remove trailing .0
        ohms_str = f"{ohms:g} megaohms"
    elif value >= 1_000:
        ohms = value / 1_000
        ohms_str = f"{ohms:g} kiloohms"
    else:
        ohms_str = f"{value} ohms"

    return f"{ohms_str} ±{tolerance}"
