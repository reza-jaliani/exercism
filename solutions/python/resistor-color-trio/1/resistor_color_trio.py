colors_list = [
    "black", "brown", "red", "orange", "yellow","green", "blue", "violet", "grey", "white"
]

def label(colors):
    c1, c2, c3 = colors[:3]
    first_digit = colors_list.index(c1)
    second_digit = colors_list.index(c2)
    main_value = first_digit * 10 + second_digit
    zeros = colors_list.index(c3)
    main_value = main_value * (10 ** zeros)
    if main_value >= 1000000000:
        return f"{main_value / 1000000000:.0f} gigaohms"
    elif main_value >= 1000000:
        return f"{main_value / 1000000:.0f} megaohms"
    elif main_value >= 1000:
        return f"{main_value / 1000:.0f} kiloohms"
    else:
        return f"{main_value} ohms"