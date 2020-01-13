from tile import Tile 
import pygame 
import time, random
from pygame.locals import *

class Game:
   # An object in this class represents a complete game.

   def __init__(self, window):
      # Initialize a Game.
      # - self is the Game to initialize
      # - window is the uagame window object
      
      self.window = window
      Tile.set_window(window)
      self.window.set_font_size(80)
      self.close_clicked = False
      self.continue_game = True
      self.tile_grid = []
      self.grid_size = 4
      self.create_tile_grid()
      self.total_time = 0
      self.score = 0
      self.matched_tiles = 0
      self.active_tiles = []
      self.delay_start_time = None
      self.restart_message = "You win. Press enter to play again"
   
      
   def create_image_list(self):
      # Creates a list of images
      
      list_of_images = []
      for index in range(1,9):
         list_of_images.append(pygame.transform.scale(pygame.image.load('image'+str(index)+'.bmp').convert(),Tile.size))
      list_of_images.extend(list_of_images)
      random.shuffle(list_of_images)
      return list_of_images
   
   def create_tile_grid(self):
      # create list of list of images
      
      image_list = self.create_image_list()
      initial_offset = 3
      count = 0
      tile_and_border = Tile.size[0]+Tile.border
      for row_index in range(self.grid_size):
         row = []
         for col_index in range(self.grid_size):
            row.append(Tile([initial_offset+tile_and_border*col_index,initial_offset+tile_and_border*row_index],image_list[count]))
            count += 1 
         self.tile_grid.append(row)

   def play(self):
      # Play the game until the player presses the close box.
      # - self is the Game that should be continued or not.
      
      while not self.close_clicked:  # until player clicks close box
          # play frame
         self.handle_event()
         self.draw()     
         if self.continue_game:
            self.update()
            self.decide_continue()
         else:
            self.restart_game()

   def restart_game(self):
      # Resets the initilized variables of the game incase the player wants
      # to play again.
      # - self is the Game whose inititialized values will be reset
      
      self.window.set_font_color("green")
      self.window.set_font_size(30)
      self.window.input_string(self.restart_message, (self.window.get_width() - self.window.get_string_width(self.restart_message))/2, (self.window.get_height() - self.window.get_font_height())/2)      
      self.window.set_font_color("white")
      self.continue_game = True
      self.tile_grid = []
      self.create_tile_grid()
      self.matched_tiles = 0
      self.active_tiles = []
      self.delay_start_time = None
      self.total_time = pygame.time.get_ticks()
      self.score = 0

   def handle_event(self):
      # Handle each user event by changing the game state
      # appropriately.
      # - self is the Game whose events will be handled

      event = pygame.event.poll()
      if event.type == QUIT:
         self.close_clicked = True
      elif event.type == MOUSEBUTTONUP and self.continue_game and len(self.active_tiles)<2:
         self.handle_mouse_up(event.pos)

   def handle_mouse_up(self,position):
      # Respond to the player releasing the mouse button by
      # taking appropriate actions.
      # - self is the Game where the mouse up occurred

      for row in self.tile_grid:
         for tile in row:
            if tile.select(position):
               tile.set_exposed()
               self.active_tiles.append(tile)
      if len(self.active_tiles) == 2:
         if self.active_tiles[0] == self.active_tiles[1]:
            self.matched_tiles += 2
            self.active_tiles = []
         else:
            self.delay_start_time = pygame.time.get_ticks()
            
            
   def delay_active_tiles(self):
      # keeps track of delay time and then hides active tiles

      if self.delay_start_time != None and pygame.time.get_ticks()-self.delay_start_time >= 750:
         self.delay_start_time = None
         for tile in self.active_tiles:
            tile.exposed = False
         self.active_tiles = []      

   def draw(self):
      # Draw all game objects.
      # - self is the Game to draw
      
      self.window.clear()
      self.draw_scoreboard()
      for row in self.tile_grid:
         for tile in row:
            tile.draw()
      self.window.update()
      
   def draw_scoreboard(self):
      # draw the scoreboard in the top right
      
      self.window.draw_string(str(self.score), self.window.get_width()-self.window.get_string_width(str(self.score)), 0)

   def update(self):
      # Update the game objects.
      # - self is the Game to update
      
      self.score = (pygame.time.get_ticks() - self.total_time) // 1000
      self.delay_active_tiles()
         
   def decide_continue(self):
      # Check and remember if the game should continue
      # - self is the Game to check
      
      if self.matched_tiles == self.grid_size ** 2:
         self.continue_game = False