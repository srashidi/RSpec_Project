class Player

	# Player object's color is readable
	attr_reader :color

	# Create Player object with given color
	def initialize(color)
		@color = color
	end

end