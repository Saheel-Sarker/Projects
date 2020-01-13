from Player import Player
from Table import Table
import pickle
import os

def main():
    print('Welcome to Casino War')
    run_game = True
    player = Player()
    table = Table()
    first_hand = True
    hands_played = 0
    winning_hands = 0
    total_bought = 0
    total_bets = 0
    total_wars = 0
    while run_game:
        print('\nYou currently have %i chips.' %player.get_chips(), 'What would you like to do?', sep = '\n')
        response = validate('\nPlay(P)\nBuy chips(B)\nQuit(Q): ', ['p', 'b', 'q'])
        if response == 'b': # If he buy's chips
            try:
                bought_chips = int(input('How many chips would you like to buy?(1-1000): '))
                assert(1 <= bought_chips <= 1000), 'Invalid transaction, a number between 1 and 1000 should be inserted.\nReturning to main menu.'
            except ValueError:
                print('Invalid amount.')
            except AssertionError as issue:
                print(issue)
            else:
                player.add_chips(bought_chips)	
                total_bought += bought_chips
        elif response == 'p': # If he plays the game
            print('Place your bet!')           
            try:
                bet = int(input('The bet should be an even number 2-100: '))
                assert(bet <= 100), 'Bet is too large.'
                assert(bet >= 2), 'Bet is too small.'
                assert(bet % 2 == 0), 'Bet is odd, should be even.'
                assert(bet <= player.get_chips()), 'Bet is greater that player\'s total chips.'
            except ValueError:
                print('Invalid amount.')	
            except AssertionError as issue:
                print(issue)
            else: # This is where the actualy playing happens
                total_bets += bet
                hands_played += 1
                if first_hand:
                    print('First hand of the shoe, burning one card.')
                    table.make_shoe()
                    table.discard()                     
                    first_hand = False
                elif table.if_remake(): # Checks if the shoe needs to be remade
                    print('Reshuffling\nFirst hand of the new shoe, burning one card.')
                    table.remake_shoe()
                    table.discard()	  
                print('No more bets!')
                player.remove_chips(bet)
                table.set_bet(bet * 2) 
                result = match(table)
                if result == -1:                            
                    print('Dealer wins.')
                elif result == 1:                           
                    print('Player wins!')
                    player.add_chips(table.get_bet())
                    winning_hands += 1
                elif result == 0: # This handles what to do with possible wars                           
                    total_wars += 1
                    want_war = validate('War!!! Would you like to go to war(W) or surrender(S)? ', ['w', 's']) 
                    if want_war == 'w':
                        accept_war = True	                           
                        if  bet > player.get_chips(): # Checks if the player can even wager more money for war.
                            accept_war = False
                            need_chips = validate('Don\'t have enough chips to go to war. Want to buy more? (Y, N)', ['y', 'n'])
                            if need_chips == 'y':
                                total_bought += bet
                                player.add_chips(bet)
                                accept_war = True
                            elif need_chips == 'n':
                                player.add_chips(table.get_bet()//4)
                        if accept_war: # Happens if the player has enough chips to go to war.   
                            player.remove_chips(bet)
                            table.add_chips(bet)
                            print('We are going to War!!! You doubled up your bet.\nBurning three cards.')
                            for times in range(3):
                                table.discard()	
                            result = match(table)
                            if result == 0 or result == 1:
                                winning_hands += 1
                                print('Player wins!')
                                player.add_chips(table.get_bet())
                            elif result == -1:
                                print('Dealer wins.')
                    elif want_war == 's':
                        player.add_chips(table.get_bet()//4)
        elif response == 'q':
            if hands_played == 0:
                average_bet = 0
                average_profit = 0
                average_wins = 0
            else:
                average_bet = proper_value(total_bets/hands_played)
                average_profit = proper_value((player.get_chips() - total_bought)/ hands_played)
                average_wins = proper_value(winning_hands / hands_played * 100)
            print('Played %i hands' %hands_played, 'From these hands, %i were war hands' %total_wars, 'The average bet was %.3f chips' %average_bet, 'The average profit of the session was %.3f' %average_profit, 'Player won %i out of %i hands, or %.3f%%' %(winning_hands, hands_played, average_wins ), 'Goodbye', sep = '\n')
            run_game = False

def proper_value(value): # Get's the numbers to have 3 digits after the decimal with no rounding
    string_value = str(value)
    dot_position = string_value.find('.')
    return float(string_value[:dot_position + 4])

def match(table): # Used to see what happens each showdown
    player_card = table.draw()
    dealer_card = table.draw()
    print('Player shows %s, Dealer shows %s' %(player_card.get(), dealer_card.get()))
    result = table.resolve_round(player_card, dealer_card)
    table.clear()
    return result	

def validate(message, valid_responses): # Validates the players response for the 3 options. Came from my assignment 2 main file.
    response = ''
    while response not in valid_responses:
        response = input(message).lower()
        if response not in valid_responses:
            print('Invalid input.')		
    return response

if __name__ == "__main__":
    main()
