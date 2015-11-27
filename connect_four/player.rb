class Player

	# Player object's color is readable
	attr_reader :color

  #Player object's pieces array is accessible
	attr_accessor :pieces

	# Create Player object with given color and
  # a blank pieces array
	def initialize(color)
		@color = color
		@pieces = []
	end

end