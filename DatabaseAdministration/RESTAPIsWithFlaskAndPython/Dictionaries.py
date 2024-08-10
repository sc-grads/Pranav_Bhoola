friend_ages = {"Rolf": 24, "Adam": 30, "Anne": 27}

friend_ages["Rolf"] = 20

print(friend_ages)

friends = [
    {"name": "Rolf", "age": 24},
    {"name": "Adam", "age": 30},
    {"name": "Anne", "age": 27}
]

print(friends[1]["name"])

student_attendances = {"Rolf": 96, "Bob": 80, "Anne": 100}

for student in student_attendances:
    print(f"{student}: {student_attendances[student]}%")