def translate(text: str) -> str:
    return " ".join(translate_word(word) for word in text.split())


def translate_word(word: str) -> str:
    vowels = ("a", "e", "i", "o", "u")

    # Rule 1 — starts with vowel or xr or yt
    if word.startswith(vowels) or word.startswith(("xr", "yt")):
        return word + "ay"

    # Special: consonant(s) + "qu" at the start
    if word.startswith("qu"):
        return word[2:] + "quay"

    # If "qu" appears before the first vowel, include it as part of the consonant cluster
    if "qu" in word:
        qu_index = word.index("qu")
        # Find first vowel
        for i, ch in enumerate(word):
            if ch in vowels:
                first_vowel_index = i
                break
        else:
            first_vowel_index = None

        # "qu" is part of the cluster only if it appears before the first vowel
        if first_vowel_index is not None and qu_index < first_vowel_index:
            return word[qu_index+2:] + word[:qu_index+2] + "ay"

    # Regular consonant cluster
    for i, ch in enumerate(word):
        if ch in vowels:
            return word[i:] + word[:i] + "ay"

    # consonant(s) + y rule
    if "y" in word:
        idx = word.index("y")
        if idx > 0:
            return word[idx:] + word[:idx] + "ay"

    return word + "ay"
