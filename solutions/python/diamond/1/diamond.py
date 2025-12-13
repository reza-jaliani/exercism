import string

def rows(letter):
    index = string.ascii_uppercase.index(letter)

    lines = []

    for i in range(index + 1):
        current_letter = string.ascii_uppercase[i]

        outer_spaces = index - i
        if i == 0:
            line = (
                " " * outer_spaces +
                current_letter +
                " " * outer_spaces
            )
        else:
            inner_spaces = 2 * i - 1
            line = (
                " " * outer_spaces +
                current_letter +
                " " * inner_spaces +
                current_letter +
                " " * outer_spaces
            )

        lines.append(line)

    for i in range(index - 1, -1, -1):
        current_letter = string.ascii_uppercase[i]
        outer_spaces = index - i

        if i == 0:
            line = (
                " " * outer_spaces +
                current_letter +
                " " * outer_spaces
            )
        else:
            inner_spaces = 2 * i - 1
            line = (
                " " * outer_spaces +
                current_letter +
                " " * inner_spaces +
                current_letter +
                " " * outer_spaces
            )

        lines.append(line)

    return lines
