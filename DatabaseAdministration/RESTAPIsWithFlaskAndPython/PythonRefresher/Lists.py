numbers = [1, 3, 5]
doubled = [num*2 for num in numbers]

for num in numbers:
    doubled.append(num*2)


friends = ["Rolf", "Sam", "Samantha", "Saurabh", "Jen"]
starts_s = []

for friend in friends:
    if friend.startswith("S"):
        starts_s.append(friend)

print(starts_s)