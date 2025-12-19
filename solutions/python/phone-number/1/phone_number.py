class PhoneNumber:
    def __init__(self, number):
        # Check for letters first
        if any(c.isalpha() for c in number):
            raise ValueError("letters not permitted")

        # Check for invalid punctuations (anything that's not digit or allowed separators)
        for c in number:
            if not c.isdigit() and c not in " .-()+": 
                raise ValueError("punctuations not permitted")

        # Extract digits only
        digits = "".join(c for c in number if c.isdigit())

        # Digit count validation
        if len(digits) < 10:
            raise ValueError("must not be fewer than 10 digits")

        if len(digits) > 11:
            raise ValueError("must not be greater than 11 digits")

        # Handle country code
        if len(digits) == 11:
            if digits[0] != "1":
                raise ValueError("11 digits must start with 1")
            digits = digits[1:]

        # Area code validation
        area = digits[:3]
        exchange = digits[3:6]

        if area[0] == "0":
            raise ValueError("area code cannot start with zero")
        if area[0] == "1":
            raise ValueError("area code cannot start with one")

        # Exchange code validation
        if exchange[0] == "0":
            raise ValueError("exchange code cannot start with zero")
        if exchange[0] == "1":
            raise ValueError("exchange code cannot start with one")

        self.number = digits

    @property
    def area_code(self):
        return self.number[:3]

    def pretty(self):
        return f"({self.number[:3]})-{self.number[3:6]}-{self.number[6:]}"
