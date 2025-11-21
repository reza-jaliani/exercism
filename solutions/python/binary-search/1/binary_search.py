def find(search_list, value):
    #search_list = sorted(search_list)
    left = 0
    right = len(search_list) - 1
    while left <= right:
        mid = (left + right) // 2
        mid_value = search_list[mid]
        if mid_value == value:
            return mid
        elif mid_value < value:
            left = mid + 1
        else:
            right = mid - 1
    raise ValueError("value not in array")