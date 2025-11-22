def transform(legacy_data):
    new = {}
    for points, letters in legacy_data.items():
        for letter in letters:
            new[letter.lower()] = points
    return new