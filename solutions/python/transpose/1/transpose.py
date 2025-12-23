def transpose(text: str) -> str:
    if not text:
        return ""

    lines = text.split("\n")
    max_len = max(len(line) for line in lines)

    padded = [line.ljust(max_len) for line in lines]

    transposed_lines = []

    for col in range(max_len):
        new_line = "".join(row[col] for row in padded)
        chars = list(new_line)

        row_index = len(lines) - 1
        while (
            chars
            and chars[-1] == " "
            and col >= len(lines[row_index])
        ):
            chars.pop()
            row_index -= 1

        transposed_lines.append("".join(chars))

    return "\n".join(transposed_lines)
