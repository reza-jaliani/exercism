def prime(number):
    if number < 1:
        raise ValueError("there is no zeroth prime")

    primes = []
    current = 2

    while len(primes) < number:
        if is_prime(current):
            primes.append(current)
        current += 1
    return primes[-1]

def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            return False
    return True