def add (x,y):
    result = x + y
    print(result)

add(5,3)


def say_hello(name, surname):
    print(f"hello, {name} {surname}")

say_hello(surname="Bob", name="Smith")

def divide(dividend, divisor):
    if divisor != 0:

        print(dividend/divisor)
    else:
        print("You can't divide by zero!")