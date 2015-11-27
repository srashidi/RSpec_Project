require './player'
require './cage'

class ConnectFour

	# Starts a new game of Connect Four and immediately
	# starts the introduction
	def initialize
		@cage = Cage.new
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

	# Allows Player 1 to select color
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
		first_turn
	end

	# Introduces the first turn
	def first_turn
		puts "Player 1 starts."
		help
		turn(@player1)
	end

	# A player's turn
	def turn(player)
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
		input = gets.chomp.strip
		if /[^1-7]/ =~ input
			input = input.downcase
			if input == "display"
				@cage.display
				turn(player)
			elsif input == "help"
				help
				turn(player)
			elsif input == "exit"
				puts "Goodbye!"
			else
				puts "Error: Invalid input. Try again..."
				turn(player)
			end
		else
			column = input.to_i
			move = @cage.place_piece(player.color,column)
			@cage.display
			unless move == :FullColumnError
				player.pieces << move
				if win?(player,move)
					puts ""
					puts "Four in a row! #{player_string} wins!"
					return play_again
				end
			end
			turn(player) if move == :FullColumnError
			turn(@player2) if player == @player1
			turn(@player1) if player == @player2
		end
	end

	# Prompts user to play again
	def play_again
		puts ""
		puts "Play again?"
		input = gets.chomp.strip.downcase
		case input
		when "yes"
			puts ""
			ConnectFour.new
		when "no"
			puts ""
			puts "Goodbye!"
		else
			puts "Error: Invalid input. Try again..."
			play_again(input)
		end
	end


	# Based on a given piece, returns an array of all
	# possible winning combinations relative to that piece
	def win_possibilities(piece)
		[ [ [piece[0],piece[1]],[piece[0]+1,piece[1]],[piece[0]+2,piece[1]],[piece[0]+3,piece[1]] ],
		[ [piece[0]-1,piece[1]],[piece[0],piece[1]],[piece[0]+1,piece[1]],[piece[0]+2,piece[1]] ],
		[ [piece[0]-2,piece[1]],[piece[0]-1,piece[1]],[piece[0],piece[1]],[piece[0]+1,piece[1]] ],
		[ [piece[0]-3,piece[1]],[piece[0]-2,piece[1]],[piece[0]-1,piece[1]],[piece[0],piece[1]] ],
		[ [piece[0],piece[1]],[piece[0],piece[1]+1],[piece[0],piece[1]+2],[piece[0],piece[1]+3] ],
		[ [piece[0],piece[1]-1],[piece[0],piece[1]],[piece[0],piece[1]+1],[piece[0],piece[1]+2] ],
		[ [piece[0],piece[1]-2],[piece[0],piece[1]-1],[piece[0],piece[1]],[piece[0],piece[1]+1] ],
		[ [piece[0],piece[1]-3],[piece[0],piece[1]-2],[piece[0],piece[1]-1],[piece[0],piece[1]] ],
		[ [piece[0],piece[1]],[piece[0]+1,piece[1]+1],[piece[0]+2,piece[1]+2],[piece[0]+3,piece[1]+3] ],
		[ [piece[0]-1,piece[1]-1],[piece[0],piece[1]],[piece[0]+1,piece[1]+1],[piece[0]+2,piece[1]+2] ],
		[ [piece[0]-2,piece[1]-2],[piece[0]-1,piece[1]-1],[piece[0],piece[1]],[piece[0]+1,piece[1]+1] ],
		[ [piece[0]-3,piece[1]-3],[piece[0]-2,piece[1]-2],[piece[0]-1,piece[1]-1],[piece[0],piece[1]] ],
		[ [piece[0],piece[1]],[piece[0]+1,piece[1]-1],[piece[0]+2,piece[1]-2],[piece[0]+3,piece[1]-3] ],
		[ [piece[0]-1,piece[1]+1],[piece[0],piece[1]],[piece[0]+1,piece[1]-1],[piece[0]+2,piece[1]-2] ],
		[ [piece[0]-2,piece[1]+2],[piece[0]-1,piece[1]+1],[piece[0],piece[1]],[piece[0]+1,piece[1]-1] ],
		[ [piece[0]-3,piece[1]+3],[piece[0]-2,piece[1]+2],[piece[0]-1,piece[1]+1],[piece[0],piece[1]] ] ]
	end

	# Checks to see if a move made is a winning move
	def win?(player,piece)
		win_possibilities(piece).each do |possibility|
			return true if possibility - player.pieces == []
		end
		false
	end

	# Displays helpful gameplay information
	def help
		puts "Choose a column from the cage"
		puts "below to place your piece, which"
		puts "will drop to the lowest available"
		puts "row in that column."
		puts ""
		puts "  1    2    3    4    5    6    7"
		puts "|    |    |    |    |    |    |    |"
		puts "|    |    |    |    |    |    |    |"
		puts "|    |    |    |    |    |    |    |"
		puts "|    |    |    |    |    |    |    |"
		puts "|    |    |    |    |    |    |    |"
		puts "|    |    |    |    |    |    |    |"
	end

end