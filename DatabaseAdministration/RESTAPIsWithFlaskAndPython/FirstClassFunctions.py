def deivide(deividend, divisor):
    if divisor == 0:
        raise ZeroDivisionError("Deivisor cannot be zero")
    return deividend / divisor

def calculate(*values, operator):
    return operator(*values)

result = calculate (20, 4, operator=deivide)
print(result)


def search(sequence, expected, finder):
    for elem in sequence:
        if finder(elem) == expected:
            return elem
    raise RuntimeError(f"Could not find an element with {expected}")

friends = [
    {"name": "Rolf Smith", "age": 24},
    {"name": "Adam Wool", "age": 30},
    {"name": "Anne Pun", "age": 27}
]

def get_friend_name(friend):
    return friend["name"]

print(search(friends, "Rolf Smith", get_friend_name))
