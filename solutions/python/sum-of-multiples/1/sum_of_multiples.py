def sum_of_multiples(limit, factors):
    multiples = set()

    for f in factors:
        if f == 0:
            if limit > 0:
                multiples.add(0)
            continue

        for m in range(f, limit, f):
            multiples.add(m)

    return sum(multiples)
