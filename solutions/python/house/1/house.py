def recite(start_verse, end_verse):
    parts = [
        "the house that Jack built.",
        "the malt",
        "the rat",
        "the cat",
        "the dog",
        "the cow with the crumpled horn",
        "the maiden all forlorn",
        "the man all tattered and torn",
        "the priest all shaven and shorn",
        "the rooster that crowed in the morn",
        "the farmer sowing his corn",
        "the horse and the hound and the horn"
    ]

    actions = [
        "",  # unused for verse 1
        "that lay in",
        "that ate",
        "that killed",
        "that worried",
        "that tossed",
        "that milked",
        "that kissed",
        "that married",
        "that woke",
        "that kept",
        "that belonged to"
    ]

    verses = []

    for v in range(start_verse, end_verse + 1):
        # start with main subject
        parts_list = ["This is " + parts[v - 1]]

        # add embeddings inline (NOT newlines!)
        for i in range(v - 1, 0, -1):
            parts_list.append(actions[i] + " " + parts[i - 1])

        # join everything with a space
        verse = " ".join(parts_list)
        verses.append(verse)

    return verses
