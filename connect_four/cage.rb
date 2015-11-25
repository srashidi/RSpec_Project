class Cage

	RED = "\u{1F534}"
	BLACK = "\u{2b24}"

	attr_reader :row1, :row2, :row3, :row4, :row5, :row6

	COL1 = 2
	COL2 = 7
	COL3 = 12
	COL4 = 17
	COL5 = 22
	COL6 = 27
	COL7 = 32

	def initialize
		@row1 = "|    |    |    |    |    |    |    |"
		@row2 = "|    |    |    |    |    |    |    |"
		@row3 = "|    |    |    |    |    |    |    |"
		@row4 = "|    |    |    |    |    |    |    |"
		@row5 = "|    |    |    |    |    |    |    |"
		@row6 = "|    |    |    |    |    |    |    |"
	end

	def display
		puts @row1
		puts @row2
		puts @row3
		puts @row4
		puts @row5
		puts @row6
	end

	def place_piece(player_color,column_choice)
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

		color = case player_color
		when :red
			RED
		when :black
			BLACK
		end

		if /\s/ =~ @row6[column]
			@row6[column] = color
		elsif /\s/ =~ @row5[column]
			@row5[column] = color
		elsif /\s/ =~ @row4[column]
			@row4[column] = color
		elsif /\s/ =~ @row3[column]
			@row3[column] = color
		elsif /\s/ =~ @row2[column]
			@row2[column] = color
		elsif /\s/ =~ @row1[column]
			@row1[column] = color
		else
			puts "Error: Column is full. Try again..."
		end
	end

end