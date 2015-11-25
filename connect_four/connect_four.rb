require './player'
require './cage'

class ConnectFour

	# Starts a new game of Connect Four and immediately
	# starts the introduction
	def initialize
		introduction
	end

	# Introduces the game before allowing for color selection
	def introduction
		puts "You have started a new game of Connect Four!"
		puts "This is a two-player game. Each player must"
		puts "choose a different color, red or black."
		puts "The first person to get four of their own"
		puts "pieces in a row (horizontally, vertically,"
		puts "or diagonally) wins the game."
		color_selection
	end

	# Allows Player 1 to select his/her color
	def color_selection
		puts "Player 1, do you choose \"red\" or \"black\"?"
		color = gets.chomp.strip.downcase
		case color
		when "red"
			@player1 = Player.new(:red)
			@player2 = Player.new(:black)
		when "black"
			@player1 = Player.new(:black)
			@player2 = Player.new(:red)
		else
			puts "Error: Invalid entry. Try again..."
			color_selection
		end
	end

end