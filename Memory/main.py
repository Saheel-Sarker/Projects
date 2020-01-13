# Memory V-3
# The player tries to find two matching tiles by selecting tiles from a 
# rectangular grid. It tracks the score of the player as the time taken to 
# complete the game, where a lower score is better. 
# In V-1, the game contains the complete tile grid and black panel on the right
# but there's no score in the black panel. All 8 pairs of the two tiles must be
# exposed when the game starts. Each time the game is played, the tiles must be 
# locations in the grid. Player actions are ignored.
# In V-2, the score appears in the top right of the screen. All the tiles appear
# hidden initially. The player can click on a hidden tile to reveal it. The game
# stops when all the tiles are exposed.
# In V-3, all features are implemented. When two active tiles are not matching, 
# the game will hide them both. The game ends when all matching tiles are found.
from uagame import Window
import time, random
from game import Game

# User-defined functions

def main():

   window = Window('Memory', 550, 420)
   window.set_auto_update(False)   
   game = Game(window)
   game.play()
   window.close()         

if __name__ == "__main__":
   main()
