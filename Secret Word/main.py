from WordGuess import WordGuess

def readWords(filename):
    """ Read in the list of possible secret words and their corresponding hints """
    file = open(filename, 'r')
    wordDic = {}
    for line in file:
        listLine = line.split()
        wordDic[listLine[0]] = listLine[1]
    file.close()
    return wordDic

def main(): # Makes sure to put try and except.
    keepAsking = True
    while keepAsking:
        try:
            fileName = input('Please enter a Word Guess input file: ')
            wordDic = readWords(fileName)
            keepAsking = False
        except:
            print('File not found.')
    game = WordGuess(wordDic)
    run_game = True
    while run_game:
        game.play()
        replay = validate('Would you like to play again? (y/n): ', ['y', 'n'])
        if replay == 'n':
            run_game = False

def validate(message, validResponses):
    answer = ''
    while answer not in validResponses:
        answer = input(message).lower()
    return answer

if __name__ == "__main__":
    main()