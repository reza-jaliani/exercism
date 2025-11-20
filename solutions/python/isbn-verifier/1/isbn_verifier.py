def is_valid(isbn):
    
    #---Remove "-"
    isbn = isbn.replace("-", "")

    #---Check if the len is incorrect
    if len(isbn) != 10:
        return False
        
    #---Calculate total and check validity of characters
    total = 0
    for i in range(10):
        char = isbn[i]
        if i == 9 and char.upper() == "X":
            value = 10
        else:
            if not char.isdigit():
                return False
            value = int(char)
        total += value * (10 - i)

    #--- Check if ISBN is valid
    return total % 11 == 0