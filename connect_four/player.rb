class Player

	# Player object's color is readable
	attr_reader :color
	attr_accessor :pieces

	# Create Player object with given color
	def initialize(color)
		@color = color
		@pieces = []
	end

end