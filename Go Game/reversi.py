class Reversi:
    WHITE = "w"
    BLACK = "b"
    EMPTY = "."
    SIZE = 8

    def __init__(self):
        self.newGame()
        self.current_color = self.BLACK

    def newGame(self): 
        self.gameBoard = []
        top = [' ']
        for number in range(self.SIZE):
            top.append(str(number))
        self.gameBoard.append(top)
        for number in range(self.SIZE):
            row = []
            row.append(str(number))
            for column in range(self.SIZE):
                row.append(self.EMPTY)
            self.gameBoard.append(row)
        self.gameBoard[self.SIZE//2][self.SIZE//2] = self.WHITE
        self.gameBoard[self.SIZE//2][self.SIZE//2 + 1] = self.BLACK
        self.gameBoard[self.SIZE//2 + 1][self.SIZE//2 + 1] = self.WHITE
        self.gameBoard[self.SIZE//2 + 1][self.SIZE//2] = self.BLACK

    def getScore(self, colour): 
        score = 0
        for row in self.gameBoard:
            for column in row:
                if column == colour:
                    score += 1
        return score

    def setPlayerColour(self, colour): 
        if colour == self.BLACK:
            self.playerColour = self.BLACK
            self.computerColour = self.WHITE
        else:
            self.playerColour = self.WHITE
            self.computerColour = self.BLACK

    def displayBoard(self): 
        for row in self.gameBoard:   
            print('  '.join(row))         

    def isPositionValid(self, position, colour): 
        assert(len(position) == 2), 'Input doesn\'t match required format'
        try:
            position = [int(position[0]), int(position[1])]
        except ValueError:
            raise Exception('Input doesn\'t match required format')
        for coordinate in position:
            assert(0 <= coordinate <= self.SIZE - 1), 'Invalid position: out of bound.'
        assert(len(self.helper_possible_moves(position, colour)) > 0), 'Invalid position: piece doesn\'t surround line of opponent pieces.'
        return True

    def isGameOver(self):
        game_over = True
        for row in range(self.SIZE):
            for column in range(self.SIZE):
                if len(self.helper_possible_moves([row, column], self.current_color)) > 0:
                    game_over = False
        if self.current_color == self.BLACK: # Sets up the next color to check for 
            self.current_color = self.WHITE
        else:
            self.current_color = self.BLACK
        return game_over

    def makeMovePlayer(self, position): 
        human_play = self.helper_possible_moves(position, self.playerColour)
        for row, column in human_play:
            self.gameBoard[row][column] = self.playerColour       

    def makeMoveNaive(self):
        first_play = self.helper_all_dots()[0]
        for row, column in first_play:
            self.gameBoard[row][column] = self.computerColour    
        return [first_play[-1][0] - 1, first_play[-1][1] - 1]

    def makeMoveSmart(self): 
        best_play = max(self.helper_all_dots(), key = len)        
        for row, column in best_play:
            self.gameBoard[row][column] = self.computerColour
        return [best_play[-1][0] - 1, best_play[-1][1] - 1]
    
    def helper_possible_moves(self, position, colour): # Needed for a bunch of methods in this class. Returns a list of all moves that are possible for a position that is given to it.
        moves = []
        row = position[0] + 1
        column = position[1] + 1
        directions = [[0,1],[0,-1],[1,0],[-1, 0],[-1,-1],[-1,1],[1,-1],[1,1]] 
        if colour == self.WHITE:
            character = self.WHITE
            opponent = self.BLACK
        elif colour == self.BLACK:
            character = self.BLACK
            opponent = self.WHITE
        if self.gameBoard[row][column] == self.EMPTY:
            for y, x in directions:
                current_row = row + y
                current_column = column + x
                possibly_valid = []
                while current_row < self.SIZE + 1 and current_column < self.SIZE + 1 and self.gameBoard[current_row][current_column] == opponent:
                    possibly_valid.append([current_row, current_column])
                    current_row += y
                    current_column += x 
                else:
                    if current_row < self.SIZE + 1 and current_column < self.SIZE + 1 and self.gameBoard[current_row][current_column] == character:
                        for move in possibly_valid:
                            moves.append(move)
        if len(moves) > 0:
            moves.append([row, column])                                 
        return moves
    
    def helper_all_dots(self): # Used to store all of both Computer difficulty's possible moves
        all_plays = []
        for row in range(self.SIZE):
            for column in range(self.SIZE):
                moves = self.helper_possible_moves([row, column], self.computerColour)
                if moves != []:
                    all_plays.append(moves)
        return all_plays
    