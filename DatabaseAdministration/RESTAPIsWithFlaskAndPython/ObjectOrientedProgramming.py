#student = {"name": "Rolf", "grades": (89, 90, 93, 78,90)}

#def average(sequence):
 #   return sum(sequence) / len(sequence)

#print(average(student["grades"]))


class Student:

    def __init__(self, name, grades):
        self.name = name
        self.grades = grades

    def average_grades(self):
        return sum(self.grades) / len(self.grades)

student = Student("Bob", (100, 100, 93, 78, 90))
student2 = Student("Rolf", (90, 90, 93, 78, 90))

print(student.name)
print(student.average_grades())  # Call the method with parentheses

print(student2.name)
print(student2.average_grades())  # Call the method with parentheses
