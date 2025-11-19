def is_armstrong_number(number):
    digits = str(number)
    power = len(digits)
    total = sum(int(d) ** power for d in digits)
    return total == number