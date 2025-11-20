def commands(binary_str):
    actions = ["wink", "double blink", "close your eyes", "jump"]
    result = []

    for i, action in enumerate(actions):
        if binary_str[-(i+1)] == "1":
            result.append(action)

    if len(binary_str) >= 5 and binary_str[-5] == "1":
        result.reverse()
        
    return result