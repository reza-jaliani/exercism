import re
from collections import Counter

def count_words(text):
    cleaned = re.sub(r"[_]", " ", text)
    cleaned = re.sub(r"[^\w\s']", " ", cleaned)
    words = cleaned.split()
    words = [w.strip("'").lower() for w in words if w.strip("'")]
    return dict(Counter(words))