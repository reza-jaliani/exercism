def saddle_points(matrix):
    # Empty matrix → no saddle points
    if not matrix:
        return []

    row_length = len(matrix[0])

    # Check for irregular matrix
    for row in matrix:
        if len(row) != row_length:
            raise ValueError("irregular matrix")

    rows = len(matrix)
    cols = row_length

    # Max of each row
    row_maxes = [max(row) for row in matrix]

    # Min of each column
    col_mins = [min(matrix[r][c] for r in range(rows)) for c in range(cols)]

    result = []

    for r in range(rows):
        for c in range(cols):
            value = matrix[r][c]
            if value == row_maxes[r] and value == col_mins[c]:
                result.append({"row": r + 1, "column": c + 1})

    return result
