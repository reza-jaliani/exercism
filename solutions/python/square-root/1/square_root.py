def square_root(number: int) -> int:
    left = 1
    right = number

    while left <= right:
        mid = (left + right) // 2
        squared = mid * mid

        if squared == number:
            return mid
        elif squared < number:
            left = mid + 1
        else:
             right = mid - 1   