def proverb(*pieces, qualifier=None):
    # If no pieces are given, return an empty list
    if not pieces:
        return []

    lines = []

    # Generate lines for consecutive pairs
    for first, second in zip(pieces, pieces[1:]):
        lines.append(f"For want of a {first} the {second} was lost.")

    # Build the final line
    first_piece = pieces[0]
    if qualifier:
        final_want = f"{qualifier} {first_piece}"
    else:
        final_want = first_piece

    lines.append(f"And all for the want of a {final_want}.")

    return lines
