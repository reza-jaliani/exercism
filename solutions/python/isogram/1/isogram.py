def is_isogram(string):
    
    #---Convert whole string to lowercase letters
    string = string.lower()

    #---Remove spaces and "-"
    string = string.replace(" ", "").replace("-", "")

    #---Determine a free set
    seen = set()

    #---Add unique letters to seen and check duplication
    for letter in string:
        if letter in seen:
            return False
        seen.add(letter)

    return True