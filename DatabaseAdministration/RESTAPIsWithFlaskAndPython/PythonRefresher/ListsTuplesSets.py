l = ["Bob","Rolf","Anne"]
t = ("Bob","Rolf","Anne")
s = {"Bob","Rolf","Anne"}

l.append("Smith")
print(l)

l.remove("Bob")
print(l)

s.add("Smith")
print(s)


# Modify set2 so that set1.intersection(set2) returns {5, 77, 9, 12}
set1 = {14, 5, 9, 31, 12, 77, 67, 8}
set2 = {5}

set1.intersection(set2) 

