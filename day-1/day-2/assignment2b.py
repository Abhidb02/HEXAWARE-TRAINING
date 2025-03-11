def linear_search(arr, target):
    """Search for the target value in the list"""
    for i in range(len(arr)):
        if arr[i] == target:
            return i  # Return the index if found
    return -1  # Return -1 if not found

# Taking user input
n = int(input("Enter the number of elements in the array: "))
arr = []

# Input values for the array
for i in range(n):
    value = int(input(f"Enter element {i+1}: "))
    arr.append(value)

# Input target value to search
target = int(input("Enter the number to search: "))

# Perform linear search
result = linear_search(arr, target)

# Display result
if result != -1:
    print(f"Element {target} found at index {result}.")
else:
    print(f"Element {target} not found in the array.")

