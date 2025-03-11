def lin_search(ar,match):
    
    for i in range(len(ar)):
      if ar[i] == match:
         return i
      return -1
ar = [5,7,3,9,12,45]
match = 7
print(lin_search(ar,match))