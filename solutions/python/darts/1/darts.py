def score(x, y):
    distance = (x**2 + y**2) ** 0.5

    if distance > 10:
        return 0
    if distance > 5:
        return 1
    if distance > 1:
        return 5
    else:
        return 10