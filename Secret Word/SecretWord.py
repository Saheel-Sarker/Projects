from Node import Node

class linkedList:
    """ The Singly-Linked List class defined in lecture """

    def __init__(self):
        self.head = None
        self.size = 0

    def isEmpty(self):
        return self.head == None

    def length(self):
        return self.size

    def add(self, item):
        temp = Node(item, None)
        temp.setNext(self.head)
        self.head = temp
        self.size += 1

    def search(self, item):
        current = self.head
        found = False
        while current != None and not found:
            if current.getData() == item:
                found = True
            else:
                current = current.getNext()

        return found

    def index(self, item):
        current = self.head
        found = False
        index = 0
        while current != None and not found:
            if current.getData() == item:
                found = True
            else:
                current = current.getNext()
                index = index + 1

        if not found:
            index = -1

        return index

    def remove(self, item):
        current = self.head
        previous = None
        found = False
        while not found:
            if current.getData() == item:
                found = True
            else:
                previous = current
                current = current.getNext()

        if previous == None:
            self.head = current.getNext()
        else:
            previous.setNext(current.getNext())
        self.size -= 1
        return found

    def append(self, item):
        temp = Node(item, None)
        if self.head == None:
            self.head = temp
        else:
            current = self.head
            while current.getNext() != None:
                current = current.getNext()
            current.setNext(temp)
        self.size += 1

    def pop(self):
        current = self.head
        previous = None
        while current.getNext() != None:
            previous = current
            current = current.getNext()
        if previous == None:
            self.head = None
        else:
            previous.setNext(None)
        self.size -= 1
        return current.getData()

    def getHead(self):
        return self.head

    def getSomething(self, pos, want): # From this method and below are mine
        current = self.head
        previous= None    
        index = 0   
        if pos < 0:
            position = self.size + pos
        else:
            position = pos
        while index < position and current.getNext() != None: 
            current = current.getNext()
            index += 1          
        if want == 'item':
            info = current.getData()
        elif want == 'display':
            info = current.getDisplay()
        return info
        
    def insert(self, pos, item):
        if pos == 0:
            self.add(item)
        elif pos == self.size:
            self.append(item)
        else:
            current = self.head
            previous = None
            index = 0
            while index != pos:
                index += 1
                previous = current
                current = current.getNext()
            temp = Node(item, None)
            temp.setDisplay('_')
            temp.setNext(current)
            previous.setNext(temp)
            self.size += 1  
        
    def solveDisplay(self, guess): # If the guess matches any of the nodes it will make those nodes display the guess but also returns if any of the nodes were equal to the guess. 
        updated = False
        current = self.head
        while current != None:
            if current.getData() == guess:
                current.setDisplay(guess)
                updated = True
            current = current.getNext()   
        return updated
    
    def removeAtIndex(self, position):
        index = 0
        current = self.head
        previous = None
        while index < position:
            previous = current
            current = current.getNext()
            index += 1
        if previous != None:
            previous.setNext(current.getNext())
        else:
            self.head = self.head.getNext()
        self.size -= 1
        
class SecretWord:

    def __init__(self):
        self.linkedList = linkedList()

        # Additional attribute(s) go here:

    def setWord(self, word):
        """ Adds the characters in 'word' to self.linkedList in the given order """
        for letter in word:
            self.linkedList.append(letter)
        
    def sort(self): # Use Insertion Sort
        """ Sorts the characters stored in self.linkedList in alphabetical order """
        index = 1
        sortedWord = SecretWord()
        sortedWord.setWord(self.get())
        while index < sortedWord.linkedList.length():
            temp = sortedWord.linkedList.getSomething(index, 'item')
            sortedWord.linkedList.removeAtIndex(index)
            position = index
            while position > 0 and sortedWord.linkedList.getSomething(position - 1, 'item') > temp:
                position -= 1
            sortedWord.linkedList.insert(position, temp)
            index += 1
        return sortedWord
            
    def isSolved(self):
        """ Returns whether SecretWord has been solved (all letters in the word have been guessed by the user) """
        solved = True
        index = 0
        while index < self.linkedList.length():
            if self.linkedList.getSomething(index, 'display') == '_':
                solved = False
            index += 1
        return solved

    def update(self, guess):
        """ Updates the Nodes in self.linkedList that match 'guess' """         
        return self.linkedList.solveDisplay(guess)

    def printProgress(self):
        """ Prints the current game progress
        Ex: y _l l _w """
        index = 0
        word = ''
        while index < self.linkedList.length():
            word += self.linkedList.getSomething(index, 'display') + ' '
            index += 1
        print(word)

    def __str__(self):
        """ Converts the characters in self.linkedList into a string """
        index = 0
        word = ''
        while index < self.linkedList.length():
            word += self.linkedList.getSomething(index, 'item')
            index += 1
        return word        

    def get(self):
        return str(self)