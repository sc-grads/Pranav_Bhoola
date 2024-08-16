t = 5,11
x, y = t

print(x, y)

student_attendances = {"Rolf": 96, "Bob": 80, "Anne": 100}


#print(list(student_attendances.items()))

for student, attendance in student_attendances.items():
    print(f"{student}: {attendance}%")


people = [("Bob", 42, "Mechanic"), ("James", 24, "Artist"), ("Harry", 32, "Lecturer")]

for name, age, profession in people:
    print(f"Name: {name}, Age: {age}, Profession: {profession}")
    