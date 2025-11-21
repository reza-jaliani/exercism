def append(list1, list2):
    result = []
    for x in list1:
        result.append(x)
    for x in list2:
        result.append(x)
    return result


def concat(lists):
    result = []
    for list in lists:
        for x in list:
            result.append(x)
    return result


def filter(function, list):
    result = []
    for x in list:
        if function(x):
            result.append(x)
    return result


def length(list):
    count = 0
    for x in list:
        count += 1
    return count


def map(function, list):
    result = []
    for x in list:
        result.append(function(x))
    return result


def foldl(function, list, initial):
    acc = initial
    for x in list:
        acc = function(acc, x)
    return acc


def foldr(function, list, initial):
    acc = initial
    for x in reverse(list):
        acc = function(acc, x)
    return acc


def reverse(list):
    result = []
    for i in range(length(list) - 1, -1, -1):
        result.append(list[i])
    return result
