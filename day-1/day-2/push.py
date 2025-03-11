def __init__(self):
        self.stack = []
       
def push(self,item):
        self.stack.append(item)
   
def display(self):
         print(self.stack)
       
Stack1 = stack()
Stack1.push(1)
Stack1.push(True)
Stack1.push(3)
 
Stack1.display()
def __init__(self,size):
    self.size = size
    self.data = [None] * size #initialize the array with None values
   
  def setvalues(self,index,value):
    if 0 <= index < self.size:
      self.data[index] = value
    else:
      print("Index out of range")
     
  def getvalues(self,index):
    if 0 <= index < self.size:
      return self.data[index]
    else:
      print("Index out of range")
      return None
   
  def display(self):
     print(self.data)
     
#Test the class
ar = MyArray(5)
ar.setvalues(0,56)
ar.setvalues(1,78)
ar.setvalues(2,90)
ar.setvalues(3,23)
ar.setvalues(4,45)
ar.display()
print(ar.getvalues(2))
 