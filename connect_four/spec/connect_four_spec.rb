require 'spec_helper'

describe ConnectFour do

	before :each do
		@game = ConnectFour.new(:test_mode)
	end

	describe "#new" do

		it "creates a new game of Connect Four" do
			expect(@game).to be_an_instance_of ConnectFour
		end

		it "creates a new Cage object" do
			expect(@game.cage).to be_an_instance_of Cage
		end

	end

	describe "#introduction" do

		it "introduces a new game of Connect Four" do
			expect(STDOUT).to receive(:puts).with("You have started a new game of Connect Four!")
			expect(STDOUT).to receive(:puts).with("This is a two-player game. Each player must")
			expect(STDOUT).to receive(:puts).with("choose a different color, red or black.")
			expect(STDOUT).to receive(:puts).with("The first person to get four of their own")
			expect(STDOUT).to receive(:puts).with("pieces in a row (horizontally, vertically,")
			expect(STDOUT).to receive(:puts).with("or diagonally) wins the game.")
			@game.introduction
		end

	end

	describe "#color_selection" do

		before :each do
			expect(STDOUT).to receive(:puts).with("Player 1, do you choose \"red\" or \"black\"?")
		end

		context "when Player 1 chooses red" do

			context "when typed in lowercase letters" do

				before do
					@game.color_selection("red")
				end

				it "makes Player 1 red and Player 2 black" do
					expect(@game.player1).to be_an_instance_of Player
					expect(@game.player1.color).to eql :red
					expect(@game.player2).to be_an_instance_of Player
					expect(@game.player2.color).to eql :black
				end

			end

			context "when typed in capital letters" do

				before do
					@game.color_selection("RED")
				end

				it "makes Player 1 red and Player 2 black" do
					expect(@game.player1).to be_an_instance_of Player
					expect(@game.player1.color).to eql :red
					expect(@game.player2).to be_an_instance_of Player
					expect(@game.player2.color).to eql :black
				end

			end

		end

		context "when Player 1 chooses black" do

			context "when typed in lowercase letters" do

				before do
					@game.color_selection("black")
				end

				it "makes Player 1 black and Player 2 red" do
					expect(@game.player1).to be_an_instance_of Player
					expect(@game.player1.color).to eql :black
					expect(@game.player2).to be_an_instance_of Player
					expect(@game.player2.color).to eql :red
				end

			end

			context "when typed in capital letters" do

				before do
					@game.color_selection("BLACK")
				end

				it "makes Player 1 black and Player 2 red" do
					expect(@game.player1).to be_an_instance_of Player
					expect(@game.player1.color).to eql :black
					expect(@game.player2).to be_an_instance_of Player
					expect(@game.player2.color).to eql :red
				end

			end

		end

		context "when neither 'red' or 'black' is input" do

			it "gives an error message and doesn't create Player objects" do
				expect(STDOUT).to receive(:puts).with("Error: Invalid entry. Try again...")
				@game.color_selection("purple")
				expect(@game.player1).to be_nil
				expect(@game.player2).to be_nil
			end

		end

	end

	describe "#first_turn" do

		it "gives directions for Player 1 to start" do
			expect(STDOUT).to receive(:puts).with("Player 1 starts.")
			expect(STDOUT).to receive(:puts).with("Choose a column from the cage")
			expect(STDOUT).to receive(:puts).with("below to place your piece, which")
			expect(STDOUT).to receive(:puts).with("will drop to the lowest available")
			expect(STDOUT).to receive(:puts).with("row in that column.")
			expect(STDOUT).to receive(:puts).with("")
			expect(STDOUT).to receive(:puts).with("  1    2    3    4    5    6    7")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			@game.first_turn
		end

	end

	describe "#help" do

		it "outputs a helpful gameplay message" do
			expect(STDOUT).to receive(:puts).with("Choose a column from the cage")
			expect(STDOUT).to receive(:puts).with("below to place your piece, which")
			expect(STDOUT).to receive(:puts).with("will drop to the lowest available")
			expect(STDOUT).to receive(:puts).with("row in that column.")
			expect(STDOUT).to receive(:puts).with("")
			expect(STDOUT).to receive(:puts).with("  1    2    3    4    5    6    7")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
			@game.help
		end

	end

	describe "#turn" do

		before do
			expect(STDOUT).to receive(:puts).with("Player 1, do you choose \"red\" or \"black\"?")
			@game.color_selection("red")
		end

		before :each do
			expect(STDOUT).to receive(:puts).with("")
			expect(STDOUT).to receive(:puts).with("Choose a column (from the numbers 1-7):")
		end

		context "when inputing a number between 1 and 7" do

			context "when it is the first move (by Player 1)" do

				it "runs #place_piece for the Cage object with the correct color
	in the correct column and displays the game board" do
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    |    |    |    |")
					@game.turn(@game.player1,"3")
					expect(@game.cage.row1).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row2).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row3).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row4).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row5).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row6).to eql "|    |    | #{RED}  |    |    |    |    |"
				end

			end

			context "when it is a later move (sometime after the first move)" do

				before do
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    |    |    |    |")
					@game.turn(@game.player1,"3")
					expect(STDOUT).to receive(:puts).with("")
					expect(STDOUT).to receive(:puts).with("Choose a column (from the numbers 1-7):")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    | #{BLACK}  |    |    |")
					@game.turn(@game.player2,"5")
					expect(STDOUT).to receive(:puts).with("")
					expect(STDOUT).to receive(:puts).with("Choose a column (from the numbers 1-7):")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    | #{BLACK}  |    |    |")
					@game.turn(@game.player1,"3")
					expect(STDOUT).to receive(:puts).with("")
					expect(STDOUT).to receive(:puts).with("Choose a column (from the numbers 1-7):")
				end

				it "runs #place_piece for the Cage object with the correct color
	in the correct column and displays the game board" do
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{BLACK}  |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    | #{BLACK}  |    |    |")
					@game.turn(@game.player2,"3")
					expect(@game.cage.row1).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row2).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row3).to eql "|    |    |    |    |    |    |    |"
					expect(@game.cage.row4).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@game.cage.row5).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@game.cage.row6).to eql "|    |    | #{RED}  |    | #{BLACK}  |    |    |"
				end

			end

		end

		context "with a different input (not 1-7)" do

			context "when user types 'display'" do
				it "displays the current Cage object" do
					@game.cage.place_piece(:red,3)
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    | #{RED}  |    |    |    |    |")
					@game.turn(@game.player1,"display")
				end
			end

			context "when user types 'help'" do
				it "displays helpful gameplay information" do
					expect(STDOUT).to receive(:puts).with("Choose a column from the cage")
					expect(STDOUT).to receive(:puts).with("below to place your piece, which")
					expect(STDOUT).to receive(:puts).with("will drop to the lowest available")
					expect(STDOUT).to receive(:puts).with("row in that column.")
					expect(STDOUT).to receive(:puts).with("")
					expect(STDOUT).to receive(:puts).with("  1    2    3    4    5    6    7")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					expect(STDOUT).to receive(:puts).with("|    |    |    |    |    |    |    |")
					@game.turn(@game.player1,"help")
				end
			end

			context "when user types 'exit'" do
				it "gives a message and exits the game" do
					expect(STDOUT).to receive(:puts).with("Goodbye!")
					@game.turn(@game.player1,"exit")
				end
			end

			context "when neither help, display, nor exit are called" do
				it "gives an error message and doesn't place a piece in the cage" do
					expect(STDOUT).to receive(:puts).with("Error: Invalid input. Try again...")
					@game.turn(@game.player1,"pi")
				end
			end

		end

	end

end