def score(word):
    letter_scores = {
        1: "AEIOULNRST",
        2: "DG",
        3: "BCMP",
        4: "FHVWY",
        5: "K",
        8: "JX",
        10: "QZ"
    }

    score_map = {}
    for points, letters in letter_scores.items():
        for letter in letters:
            score_map[letter.lower()] = points

    total = 0
    for char in word.lower():
        total += score_map.get(char, 0)

    return total