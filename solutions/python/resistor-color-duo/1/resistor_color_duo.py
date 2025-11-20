color_list = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

def value(colors):
    first_two = colors[:2]
    #---Find index of color
    digits = [color_list.index(color) for color in first_two]
    return int("".join(map(str, digits)))