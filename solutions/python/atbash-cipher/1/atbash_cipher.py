#---Variables and Consts
import string
alphabet = string.ascii_lowercase
reversed_alphabet = alphabet[::-1]
ATBASH_MAP = {
    plain: cipher
    for plain, cipher in zip(alphabet, reversed_alphabet)
}

def encode(plain_text):
    encode_char = []
    for ch in plain_text.lower():
        if ch.isalpha():
            encode_char.append(ATBASH_MAP[ch])
        elif ch.isdigit():
            encode_char.append(ch)
    groups = [
        "".join(encode_char[i: i+5])
        for i in range(0, len(encode_char), 5)
    ]
    return " ".join(groups)


def decode(ciphered_text):
    decoded_chars = []
    for ch in ciphered_text.lower():
        if ch.isalpha():
            decoded_chars.append(ATBASH_MAP[ch])
        elif ch.isdigit():
            decoded_chars.append(ch)
    return "".join(decoded_chars)