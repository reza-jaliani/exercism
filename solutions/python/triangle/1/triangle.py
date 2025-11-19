def valid_triangle(sides):
    a, b, c = sides
    return (
        a > 0 and b > 0 and c > 0 and
        a + b >= c and
        b + c >= a and
        a + c >= b
    )


def equilateral(sides):
    a, b, c = sides
    if not valid_triangle(sides):
        return False
    return a == b == c


def isosceles(sides):
    a, b, c = sides
    if not valid_triangle(sides):
        return False
    return a == b or b == c or a == c


def scalene(sides):
    a, b, c = sides
    if not valid_triangle(sides):
        return False
    return a != b and b != c and a != c