def calculate_discriminant(a, b, c):
    # Calculate the discriminant
    D = b * b - 4 * a * c
    return D

# Read input values from the user
a = float(input("Enter coefficient a: "))
b = float(input("Enter coefficient b: "))
c = float(input("Enter coefficient c: "))

# Calculate and print the discriminant
discriminant = calculate_discriminant(a, b, c)
print("The discriminant (D) is:", discriminant)