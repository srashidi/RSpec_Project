require_relative '../connect_four'
require_relative '../player'
require_relative '../cage'

RED = "\u{1F534}"
BLACK = "\u{2b24}"

class Cage

	attr_reader :row1, :row2, :row3, :row4, :row5, :row6

end

class ConnectFour

	attr_reader :player1, :player2

	def initialize(test_mode = false)
		@test_mode = test_mode
		introduction unless @test_mode
	end

	def introduction
		puts "You have started a new game of Connect Four!"
		puts "This is a two-player game. Each player must"
		puts "choose a different color, red or black."
		puts "The first person to get four of their own"
		puts "pieces in a row (horizontally, vertically,"
		puts "or diagonally) wins the game."
		color_selection unless @test_mode
	end

	def color_selection(input)
		puts "Player 1, do you choose \"red\" or \"black\"?"
		color = input
		case color
		when "red"
			@player1 = Player.new(:red)
			@player2 = Player.new(:black)
		when "black"
			@player1 = Player.new(:black)
			@player2 = Player.new(:red)
		else
			puts "Error: Invalid entry. Try again..."
		end
	end

end