import random
from SecretWord import SecretWord

class WordGuess:

    def __init__(self, wordDic):
        self.wordDic = wordDic
        
    def play(self):
        """ Plays out a single full game of Word Guess """
        self.secretWord = SecretWord()
        self.guesses = []         
        self.chooseSecretWord()
        self.makeTable()
        numberOfGuesses = 2 * self.editDistance(self.secretWord.sort().get(), self.secretWord.get())
        if numberOfGuesses < 5:
            numberOfGuesses = 5
        elif numberOfGuesses > 15:
            numberOfGuesses = 15
        print('A secret word has been randomly chosen!')
        while not self.secretWord.isSolved() and numberOfGuesses > 0:
            print('You have %i guesses remaining' %numberOfGuesses)
            print('Word Guess Progress: ', end = '')
            self.secretWord.printProgress()
            if not self.secretWord.update(self.getGuess()):
                numberOfGuesses -= 1
        if self.secretWord.isSolved():
            print('You solved the puzzle!') 
        else:
            print('You failed to solve the puzzle.') 
        print('The secret word was: %s' %self.secretWord.get())
        
    def chooseSecretWord(self):
        """ Chooses the secret word that will be guessed """
        self.secretWord.setWord(random.choice(list(self.wordDic.keys())))
        
    def editDistance(self, s1, s2): # Solves the table. s2 will be my original word.  
        """ Recursively returns the total number of insertions and deletions required to convert S1 into S2 """
        if s1 == '':
            return self.table[-1][-1] # Get the number at the bottom right of the table
        else:
            row = -len(s1)
            column = 1
            for letter in s2:
                if s1[0] == letter: # If the letters are equal take the square on the top left of the current square
                    self.table[row][column] = self.table[row - 1][column - 1] 
                else: # Take the minimumn between the square directly above the current square and the square directly to the left of the current square. The current square will be that number.
                    minimum_edit = min(self.table[row][column - 1], self.table[row - 1][column]) + 1
                    self.table[row][column] = minimum_edit
                column += 1
            return self.editDistance(s1[1:], s2)
        
    def getGuess(self):
        """ Queries the user to guess a character in the secret word """
        guess = ''
        while guess in self.guesses or len(guess) != 1:
            guess = input('Enter a character that has not been guessed or * for a hint: ')
            if guess == '*':
                print('Hint: %s' %self.wordDic[self.secretWord.get()])
        self.guesses.append(guess)
        return guess
    
    def makeTable(self): # This table needs to be solved and the number in the bottom right of the table will be the minimum edit distance.
        self.table = []
        size = len(self.secretWord.get()) + 1
        top = []
        for number in range(size):
            top.append(number)
        self.table.append(top)
        for number in range(1, size):
            row = []
            row.append(number)
            for number in range(1, size):
                row.append(0)
            self.table.append(row)

