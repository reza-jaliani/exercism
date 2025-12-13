ONES = [
    "zero", "one", "two", "three", "four",
    "five", "six", "seven", "eight", "nine"
]

TEENS = [
    "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
]

TENS = [
    "", "", "twenty", "thirty", "forty",
    "fifty", "sixty", "seventy", "eighty", "ninety"
]

SCALES = ["", "thousand", "million", "billion"]


def say(number):
    if number < 0 or number > 999_999_999_999:
        raise ValueError("input out of range")

    if number == 0:
        return "zero"

    words = []
    scale_index = 0

    while number > 0:
        chunk = number % 1000

        if chunk != 0:
            chunk_words = say_under_1000(chunk)
            if SCALES[scale_index]:
                chunk_words += " " + SCALES[scale_index]
            words.insert(0, chunk_words)

        number //= 1000
        scale_index += 1

    return " ".join(words)


def say_under_1000(n: int) -> str:
    parts = []

    # hundreds
    if n >= 100:
        parts.append(ONES[n // 100] + " hundred")
        n %= 100

    # tens & ones
    if 10 <= n < 20:
        parts.append(TEENS[n - 10])
    else:
        tens_part = ""
        if n >= 20:
            tens_part = TENS[n // 10]
            n %= 10

        if n > 0:
            if tens_part:
                parts.append(tens_part + "-" + ONES[n])
            else:
                parts.append(ONES[n])
        else:
            if tens_part:
                parts.append(tens_part)

    return " ".join(parts)
