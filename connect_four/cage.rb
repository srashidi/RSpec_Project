class Cage

	# Constants for colored pieces
	RED = "\u{1F534}"
	BLACK = "\u{2b24}"

	# Indeces in the row strings for each column
	COL1 = 2
	COL2 = 7
	COL3 = 12
	COL4 = 17
	COL5 = 22
	COL6 = 27
	COL7 = 32

	# Creates an empty game cage
	def initialize
		@row1 = "|    |    |    |    |    |    |    |"
		@row2 = "|    |    |    |    |    |    |    |"
		@row3 = "|    |    |    |    |    |    |    |"
		@row4 = "|    |    |    |    |    |    |    |"
		@row5 = "|    |    |    |    |    |    |    |"
		@row6 = "|    |    |    |    |    |    |    |"
	end

	# Displays current game cage
	def display
		puts @row1
		puts @row2
		puts @row3
		puts @row4
		puts @row5
		puts @row6
	end

	# Places a piece of a selected color in a given column
	def place_piece(player_color,column_choice)

		# Specifies the index of the column
		column = case column_choice
		when 1
			COL1
		when 2
			COL2
		when 3
			COL3
		when 4
			COL4
		when 5
			COL5
		when 6
			COL6
		when 7
			COL7
		end

		# Specifies the color of the piece
		piece = case player_color
		when :red
			RED
		when :black
			BLACK
		end

		# Puts the piece in the lowest row with no piece
		# in the given column
		if /\s/ =~ @row6[column]
			@row6[column] = piece
		elsif /\s/ =~ @row5[column]
			@row5[column] = piece
		elsif /\s/ =~ @row4[column]
			@row4[column] = piece
		elsif /\s/ =~ @row3[column]
			@row3[column] = piece
		elsif /\s/ =~ @row2[column]
			@row2[column] = piece
		elsif /\s/ =~ @row1[column]
			@row1[column] = piece
		else
			puts "Error: Column is full. Try again..."
			:FullColumnError
		end

	end

end