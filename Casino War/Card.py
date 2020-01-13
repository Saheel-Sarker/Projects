class Card:
	def __init__(self, rank, suit):
		#TODO
		self.__ranks = {'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9,'T':10,'t':10,'J':11,'j':11,'Q':12,'q':12,'K':13,'k':13,'A':14,'a':14}
		self.__suits = {'H','h','C','c','D','d','S','s'}		
		assert(rank in self.__ranks), 'Invalid Rank'
		assert(suit in self.__suits), 'Invalid Suit'
		self.__rank = rank
		self.__suit = suit

	
	def get(self):
		return str(self)
	
	def get_rank(self): # Used to check deck
		return self.__rank
	
	def get_suit(self): # Used to check deck
		return self.__suit
	
	def __gt__(self, other):
		return self.__ranks[self.__rank] > self.__ranks[other.__rank]
		
	def __lt__(self, other):
		return self.__ranks[self.__rank] < self.__ranks[other.__rank]
	
	
	def __eq__(self, other):
		return self.__ranks[self.__rank] == self.__ranks[other.__rank]
		
	def __str__(self):
		return self.__rank.upper() + self.__suit.upper()