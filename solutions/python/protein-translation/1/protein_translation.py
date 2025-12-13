def proteins(strand):
    CODON_MAP = {
        "AUG": "Methionine",
        "UUU": "Phenylalanine",
        "UUC": "Phenylalanine",
        "UUA": "Leucine",
        "UUG": "Leucine",
        "UCU": "Serine",
        "UCC": "Serine",
        "UCA": "Serine",
        "UCG": "Serine",
        "UAU": "Tyrosine",
        "UAC": "Tyrosine",
        "UGU": "Cysteine",
        "UGC": "Cysteine",
        "UGG": "Tryptophan",
    }
    STOP_CODONS = {"UAA", "UAG", "UGA"}
    result = []
    for i in range(0, len(strand), 3):
        codon = strand[i:i + 3]
        if codon in STOP_CODONS:
            break
        result.append(CODON_MAP[codon])
    return result