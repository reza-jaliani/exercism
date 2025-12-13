def encode(text):
    if text == "":
        return ""

    encoded = []
    count = 1

    for i in range(1, len(text)):
        if text[i] == text[i - 1]:
            count += 1
        else:
            if count == 1:
                encoded.append(text[i - 1])
            else:
                encoded.append(str(count) + text[i - 1])
            count = 1

    # آخرین run
    if count == 1:
        encoded.append(text[-1])
    else:
        encoded.append(str(count) + text[-1])

    return "".join(encoded)


def decode(text):
    decoded = []
    count = ""

    for char in text:
        if char.isdigit():
            count += char
        else:
            if count == "":
                decoded.append(char)
            else:
                decoded.append(char * int(count))
                count = ""

    return "".join(decoded)
