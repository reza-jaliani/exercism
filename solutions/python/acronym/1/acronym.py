import string

def abbreviate(words):
    words = words.replace("-", " ")    

    cleaned = ""
    for ch in words:
        if ch.isalnum() or ch.isspace():
            cleaned += ch
    acronym = ""
    for word in cleaned.split():
        acronym += word[0].upper()
    return acronym