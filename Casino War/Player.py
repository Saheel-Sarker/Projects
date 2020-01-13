class Player:
	def __init__(self):
		self.__chips = 0
	
	def add_chips(self, chips):
		assert(isinstance(chips, int) and chips > 0), 'Invalid Chips'
		self.__chips += chips
		
	def remove_chips(self, chips):
		assert(isinstance(chips, int) and chips > 0), 'Invalid Chips'
		self.__chips -= chips
		
	def get_chips(self):
		return self.__chips

		
