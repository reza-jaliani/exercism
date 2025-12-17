class Luhn:
    def __init__(self, card_num):
        self.card_num = card_num

    def valid(self):
        # Remove spaces
        stripped = self.card_num.replace(" ", "")

        # Must be more than one digit
        if len(stripped) <= 1:
            return False

        # Must contain only digits
        if not stripped.isdigit():
            return False

        total = 0
        reversed_digits = stripped[::-1]

        for index, char in enumerate(reversed_digits):
            digit = int(char)

            if index % 2 == 1:  # every second digit from the right
                digit *= 2
                if digit > 9:
                    digit -= 9

            total += digit

        return total % 10 == 0
