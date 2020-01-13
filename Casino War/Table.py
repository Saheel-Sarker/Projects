from Card import Card
from random import shuffle
from queue import Queue

class Table:
	def __init__(self):
		self.__discard = Queue()

	def resolve_round(self, player, dealer):
		self.__player_card = player
		self.__dealer_card = dealer
		if player > dealer:
			return 1
		elif player < dealer:
			return -1
		elif player == dealer:
			return 0
	
	def set_bet(self, bet):
		self.__bet = bet
	
	def get_bet(self):
		return self.__bet
	
	def clear(self):
		self.__discard.enqueue(self.__player_card)
		self.__discard.enqueue(self.__dealer_card)
	
	def create_deck(self):
		ranks = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']
		suits = ['H','C','D','S']
		deck = []
		for suit in suits:
			for rank in ranks:
				deck.append(Card(rank, suit))
		return deck
			
	def validate_deck(self, deck):
		assert(len(deck) == 52), 'Not a 52 card deck.'
		for card in deck:
			try:
				Card(card.get_rank(), card.get_suit()) # Get the rank and suit and try to remake the card. If a error happens and catch it and raise another error giving a general reason why.
			except:
				raise Exception('Found an invalid card in the deck')
		for card in deck:
			already_occured = False # I need this so when I compare a card with the rest of the card in the deck, a card won't a raise an error for finding itself.
			for other_card in deck:
				if card.get() == other_card.get() and already_occured: # If already_occured is true and another 2 cards are equal, then that means there's duplicates.
					raise Exception('Duplicate cards in the deck.')
				elif card.get() == other_card.get(): # This will allow a card to be okay with finding itself once in the deck. 
					already_occured = True
		return True

	def make_shoe(self):
		pile_1 = Queue()
		pile_2 = Queue()
		decks = []
		for amount in range(6):
			decks.append(self.create_deck())
		for deck in decks[:3]:
			if self.validate_deck(deck):
				shuffle(deck)
				for card in deck:
					pile_1.enqueue(card)
		for deck in decks[3:]:
			if self.validate_deck(deck):
				shuffle(deck)	
				for card in deck:
					pile_2.enqueue(card)
		self.__shoe = Queue()
		for times in range(6):
			tempory_deck = []
			for amount in range(26):
				tempory_deck.append(pile_1.dequeue())
				tempory_deck.append(pile_2.dequeue())
			shuffle(tempory_deck)
			for card in tempory_deck:
				self.__shoe.enqueue(card)
				
	def draw(self): # Draws from the deck
		return self.__shoe.dequeue()
					
	def discard(self): # Discards a card from the deck and automatically puts it in the discard queue
		self.__discard.enqueue(self.__shoe.dequeue())
	
	def add_chips(self, chips): # Add chips
		self.__bet += chips
	
	def remake_deck(self): # Takes the cards from the discard pile and reuses them to make decks again
		deck = []
		for number in range(52):
			deck.append(self.__discard.dequeue())
		return deck
			
	def remake_shoe(self): # Remakes the shoe pretty much like like make shoe except doesn't it doesn't check for copies
		while not self.__shoe.isEmpty():
			self.__discard.enqueue(self.__shoe.dequeue())
		pile_1 = Queue()
		pile_2 = Queue()
		decks = []
		for amount in range(6):
			decks.append(self.remake_deck())
		for deck in decks[:3]:
			shuffle(deck)
			for card in deck:
				pile_1.enqueue(card)
		for deck in decks[3:]:
			shuffle(deck)	
			for card in deck:
				pile_2.enqueue(card)		
		for times in range(6):
			some_list = []
			for amount in range(26):
				some_list.append(pile_1.dequeue())
				some_list.append(pile_2.dequeue())
			shuffle(some_list)
			for card in some_list:
				self.__shoe.enqueue(card)
	
	def if_remake(self): # Checks if the shoe needs to be remade
		if self.__shoe.size() < 52:
			return True	
		else:
			return False
		
		
