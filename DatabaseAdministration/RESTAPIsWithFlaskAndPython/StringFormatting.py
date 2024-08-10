name = "Bob"
greeting = f"Hello, {name}" 

print (greeting)

name = "Bob"    
greeting = "Hello,{}"
with_name = greeting.format(name)
with_name2 = greeting.format("Rolf")

print (with_name)
print (with_name2)

longer_phrase = "Hello, {}. Today is {}"
formatted = longer_phrase.format("Ralf", "Monday")

print (formatted)