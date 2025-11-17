"""Functions for creating, transforming, and adding prefixes to strings."""


def add_prefix_un(word):
    """Take the given word and add the 'un' prefix."""

    return "un" + word


def make_word_groups(vocab_words):
    """Transform a list containing a prefix and words into a string with the prefix followed by the words with prefix prepended."""

    prefix = vocab_words[0]
    prefixed_words = [prefix] + [prefix + word for word in vocab_words[1:]]
    return " :: ".join(prefixed_words)

def remove_suffix_ness(word):
    """Remove the suffix from the word while keeping spelling in mind."""

    root = word[:-4]
    if root[-1:] == "i":
        root = root[:-1] + "y"
    return root

def adjective_to_verb(sentence, index):
    """Change the adjective within the sentence to a verb."""

    words = sentence.split()
    adjective = words[index].rstrip(".")
    return adjective + "en"
