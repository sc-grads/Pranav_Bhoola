def divide(dividend, divisor):
    if divisor == 0:
        raise ZeroDivisionError ("Divisor cannot be zero")
    
    return dividend/divisor


grades = []

print("Welcome to the average grade program")   
try:
    average = divide(sum(grades), len(grades))
except ZeroDivisionError as e:
    print(e)
    print("There are no grades in your list")

print (f"The average grade is {average}")

