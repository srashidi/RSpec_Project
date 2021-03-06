require_relative '../connect_four'
require_relative '../player'
require_relative '../cage'

RED = "\u{1F534}"
BLACK = "\u{2b24}"

class Cage

	attr_reader :row1, :row2, :row3, :row4, :row5, :row6

end

class ConnectFour

	attr_reader :cage, :player1, :player2

	def initialize(test_mode = false)
		@test_mode = test_mode
		@cage = Cage.new
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
		color = input.strip.downcase
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

	def first_turn
		puts "Player 1 starts."
		help
		turn(@player1) unless @test_mode
	end

	def turn(player, input)
		player_string = case player
		when @player1
			"Player 1"
		when @player2
			"Player 2"
		end
		puts ""
		puts "#{player_string} (#{player.color.to_s}), choose a column (from the numbers 1-7),"
		puts "or \"display\" the current cage, or ask"
		puts "for \"help\", or \"exit\":"
		if /[^1-7]/ =~ input
			input = input.strip.downcase
			if input == "display"
				@cage.display
			elsif input == "help"
				help
			elsif input == "exit"
				puts "Goodbye!"
			else
				puts "Error: Invalid input. Try again..."
			end
			turn(player, :new_input) unless @test_mode
		else
			column = input.strip.to_i
			move = @cage.place_piece(player.color,column)
			@cage.display
			unless move == :FullColumnError
				player.pieces << move
				if win?(player,move)
					puts ""
					puts "Four in a row! #{player_string} wins!"
				end
			end
			turn(player, :new_input) if move == :FullColumnError unless @test_mode
			turn(@player2, :new_input) if player == @player1 unless @test_mode
			turn(@player1, :new_input) if player == @player2 unless @test_mode
		end
	end

	def play_again(input)
		puts ""
		puts "Play again?"
		input = input.strip.downcase
		case input
		when "yes"
			puts ""
			ConnectFour.new(:test_mode)
		when "no"
			puts ""
			puts "Goodbye!"
		else
			puts "Error: Invalid input. Try again..."
			play_again(input) unless @test_mode
		end
	end

end