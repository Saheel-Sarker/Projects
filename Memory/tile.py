import pygame 
from pygame.locals import *

class Tile:
   # An object in this class represents a Tile.
   
   window = None
   size = [100,100]
   border = 5
   card_back = pygame.transform.scale(pygame.image.load('image0.bmp'),size)

   def __init__(self, position, image):
      # Initialize a tile.
      # - self is the tile to initialize
      # - position is a list containing the x and y int
      # coords of the top left of the tile

      self.position = position
      self.image = image
      self.exposed = False
      self.rect = pygame.Rect(position, image.get_rect().size)
      
   def __eq__(self, other):
      # overload the equality operator
      # other is the right operand
      is_equal = False
      if self.image == other.image:
         is_equal = True
      return is_equal
      
   @classmethod
   def set_window(cls, window):
      # sets the window
      
      cls.window = window   
   
   def draw(self):
      # Draw the tile.
      # - self is the tile to draw
      
      if self.exposed:
         self.window.get_surface().blit(self.image, self.position)
      else:
         self.window.get_surface().blit(Tile.card_back, self.position)
   
   def select(self, position):
      '''
      check if the mouse click was in this tile and respond accordingly
      - position is the mouse click's position
      '''
      
      return self.rect.collidepoint(position) and not self.exposed
   
   def set_exposed(self):
      # reveal the tile
      
      self.exposed = True