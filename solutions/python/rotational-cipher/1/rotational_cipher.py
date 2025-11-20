def rotate(text, key):
    result = ""

    for char in text:
        if char.isalpha():
            if char.isupper():
                shifted = (ord(char) - ord('A') + key) % 26 + ord('A')
            else:
                shifted = (ord(char) - ord('a') + key) % 26 + ord('a')
            result += chr(shifted)
        else:
            result += char

    return result