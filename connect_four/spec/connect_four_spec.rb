require 'spec_helper'

describe ConnectFour do

	before :each do
		@game = ConnectFour.new(:test_mode)
	end

	describe "#new" do

		it "creates a new game of Connect Four" do
			expect(@game).to be_an_instance_of ConnectFour
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

		context "when Player 1 chooses black" do

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

		context "when neither 'red' or 'black' is input" do

			it "gives an error message" do
				expect(STDOUT).to receive(:puts).with("Error: Invalid entry. Try again...")
				@game.color_selection("purple")
			end

		end

	end

end