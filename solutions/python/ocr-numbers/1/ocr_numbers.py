def convert(input_grid):
    # --- Validation ---
    if len(input_grid) % 4 != 0:
        raise ValueError("Number of input lines is not a multiple of four")

    for row in input_grid:
        if len(row) % 3 != 0:
            raise ValueError("Number of input columns is not a multiple of three")

    # --- OCR patterns ---
    DIGITS = {
        (
            " _ ",
            "| |",
            "|_|",
            "   ",
        ): "0",
        (
            "   ",
            "  |",
            "  |",
            "   ",
        ): "1",
        (
            " _ ",
            " _|",
            "|_ ",
            "   ",
        ): "2",
        (
            " _ ",
            " _|",
            " _|",
            "   ",
        ): "3",
        (
            "   ",
            "|_|",
            "  |",
            "   ",
        ): "4",
        (
            " _ ",
            "|_ ",
            " _|",
            "   ",
        ): "5",
        (
            " _ ",
            "|_ ",
            "|_|",
            "   ",
        ): "6",
        (
            " _ ",
            "  |",
            "  |",
            "   ",
        ): "7",
        (
            " _ ",
            "|_|",
            "|_|",
            "   ",
        ): "8",
        (
            " _ ",
            "|_|",
            " _|",
            "   ",
        ): "9",
    }

    results = []

    # --- Process blocks of 4 rows ---
    for block_start in range(0, len(input_grid), 4):
        rows = input_grid[block_start:block_start + 4]
        line_result = ""

        num_digits = len(rows[0]) // 3

        for digit_index in range(num_digits):
            digit_pattern = tuple(
                row[digit_index * 3:(digit_index + 1) * 3]
                for row in rows
            )
            line_result += DIGITS.get(digit_pattern, "?")

        results.append(line_result)

    return ",".join(results)
