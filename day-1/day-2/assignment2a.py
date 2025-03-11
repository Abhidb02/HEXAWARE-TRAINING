class MyArray:
    def __init__(self, size):
        self.size = size
        self.data = [None] * size  # Initialize the array with None values

    def create(self, index, value):
        """Add an element at a specific index"""
        if 0 <= index < self.size:
            self.data[index] = value
        else:
            print("Index out of range")

    def read(self, index):
        """Read an element from the array"""
        if 0 <= index < self.size:
            return self.data[index]
        else:
            print("Index out of range")
            return None

    def update(self, index, value):
        """Update an existing value in the array"""
        if 0 <= index < self.size:
            self.data[index] = value
        else:
            print("Index out of range")

    def delete(self, index):
        """Delete an element from the array by setting it to None"""
        if 0 <= index < self.size:
            self.data[index] = None
        else:
            print("Index out of range")

    def display(self):
        """Display the entire array"""
        print(self.data)

# Testing the CRUD Operations
arr = MyArray(5)
arr.create(0, 10)
arr.create(1, 20)
arr.create(2, 30)
arr.create(3, 40)
arr.create(4, 50)

print("Array after creation:")
arr.display()

# Reading an element
print("Element at index 2:", arr.read(2))

# Updating an element
arr.update(2, 35)
print("Array after update:")
arr.display()

# Deleting an element
arr.delete(3)
print("Array after deletion:")
arr.display()
