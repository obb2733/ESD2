# Dr. Kaputa
# hello world via a class

class Printer():
  def __init__(self):
    self.runCode()
      
  def runCode(self): 
    print ("Hello World\n")
    x = 1
    if x == 1:
        print ("hi")
  
def main():
  printer = Printer()
  
if __name__ == '__main__':
  main()