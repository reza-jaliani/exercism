def is_pangram(sentence):
    sentence = sentence.lower()
    letters = set()

    for ch in sentence:
        if 'a' <= ch <= 'z':
            letters.add(ch)

    return len(letters) == 26
