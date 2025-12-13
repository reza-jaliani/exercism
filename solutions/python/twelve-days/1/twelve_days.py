ORDINALS = [
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
]

GIFTS = [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
]

def recite(start, end):
    verses = []
    for day in range(start-1, end):
        gifts = GIFTS[:day+1][::-1]
        if day != 0:
            gifts[-1] = "and " + gifts[-1]
        verse = f"On the {ORDINALS[day]} day of Christmas my true love gave to me: " + ", ".join(gifts)
        verses.append(verse)
    return verses
