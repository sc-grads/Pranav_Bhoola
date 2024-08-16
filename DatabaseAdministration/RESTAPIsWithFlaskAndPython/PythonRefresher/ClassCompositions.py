class Bookshelf:
    def __init__(self, *books):
        self.books = books

    def __str__(self):
        return f"Bookshelf with {len(self.books)} books."
    
class Book:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return f"Book {self.name}"

# Correctly instantiate two Book objects
book1 = Book("Harry Potter")
book2 = Book("Lord of the Rings")

# Create a Bookshelf containing both books
shelf = Bookshelf(book1, book2)

# Print the bookshelf information
print(shelf)
