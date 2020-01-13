class Queue:
    def __init__(self):
        self.items = []
    
    def enqueue(self, item):
        self.items.insert(0,item)
    
    def dequeue(self):
        return self.items.pop()    
    
    def isEmpty(self):
        return self.items == []
    
    def size(self):
        return len(self.items)
    
    def show(self):
        print (self.items)
    
    def __str__(self):
        return str(self.items)
    
    def just_to_check(self): # used to test the shoe
        return self.items
    