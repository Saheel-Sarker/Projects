from reversi import Reversi

def main():
    game = Reversi()
    run_game = True
    while run_game:
        print('Starting new game!', 'Black goes first, then white', sep = '\n')
        player_color = validate('Enter \'b\' to choose to play black, \'w\' to choose white: ', ['b', 'w'])
        difficulty = validate('Enter \'1\' to choose easy computer opponent, \'2\' for hard computer opponent: ', ['1', '2'])
        game.newGame()
        game.setPlayerColour(player_color) 
        board_and_score(game)
        game_over = False
        while not game_over: # This loop is the entire round 
            if player_color == 'w': # Computer gets to go first
                if not game.isGameOver(): 
                    computer_turn(difficulty, game)
                    if not game.isGameOver():
                        game_over = human_turn(player_color, game)
                    else:
                        game_over = True
                else:
                    game_over = True
            elif player_color == 'b': # Player gets to go first
                if not game.isGameOver():
                    game_over = human_turn(player_color, game)  
                    if not game.isGameOver() and not game_over:
                        computer_turn(difficulty, game)
                    else:
                        game_over = True
                else:
                    game_over = True
        print('Game over!')
        restart = validate('Do you want to play again (y/n)? ', ['y', 'n'])
        if restart == 'n':
            print('Goodbye!')
            run_game = False

def board_and_score(game): # Display the board and then the score underneath
    game.displayBoard() 
    print('Score: white %i, black %i' %(game.getScore('w'), game.getScore('b')))    
    

def validate(message, acceptable_answers): # Validate how the player picks certain settings
    answer = ''
    while answer not in acceptable_answers:
        answer = input(message).lower()
    return answer

def computer_turn(difficulty, game): # Let's computer play with whatever difficulty given and displays his actions
    if difficulty == '1':
        made_move = game.makeMoveNaive()
    elif difficulty == '2':
        made_move = game.makeMoveSmart()
    print('Computer making move:' + str(made_move))
    board_and_score(game)

    
def human_turn(player_color, game): # Lets human play and displays his actions
    print('Enter 2 numbers from 0-7 separated by a space to make a move,', 'where the first number is the row and the second number is the column', 'Enter \'q\' to quit.', sep = '\n')
    valid_response = False
    quit = False
    while not valid_response:
        entered_move = input('Enter move: ').split()
        if entered_move in [['q'], ['Q']]:
            valid_response = True
            quit = True
        else: 
            try:
                if game.isPositionValid(entered_move, player_color):
                    game.makeMovePlayer([int(entered_move[0]), int(entered_move[1])])
                    valid_response = True
            except Exception as issue:
                print(issue)
    board_and_score(game)
    return quit

main()