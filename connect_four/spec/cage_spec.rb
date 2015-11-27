require 'spec_helper'

describe Cage do

	before :each do
		@cage = Cage.new
	end

	describe "#new" do
		it "creates a new Cage object with no pieces" do
			expect(@cage.row1).to eql "|    |    |    |    |    |    |    |"
			expect(@cage.row2).to eql "|    |    |    |    |    |    |    |"
			expect(@cage.row3).to eql "|    |    |    |    |    |    |    |"
			expect(@cage.row4).to eql "|    |    |    |    |    |    |    |"
			expect(@cage.row5).to eql "|    |    |    |    |    |    |    |"
			expect(@cage.row6).to eql "|    |    |    |    |    |    |    |"
		end
	end

	describe "#display" do

		it "displays the current cage" do
			expect(STDOUT).to receive(:puts).with("")
			expect(STDOUT).to receive(:puts).with("  1    2    3    4    5    6    7")
			expect(STDOUT).to receive(:puts).with(@cage.row1)
			expect(STDOUT).to receive(:puts).with(@cage.row2)
			expect(STDOUT).to receive(:puts).with(@cage.row3)
			expect(STDOUT).to receive(:puts).with(@cage.row4)
			expect(STDOUT).to receive(:puts).with(@cage.row5)
			expect(STDOUT).to receive(:puts).with(@cage.row6)
			expect(STDOUT).to receive(:puts).with("")
			@cage.display
		end

	end

	describe "#place_piece" do

		context "when column is empty" do

			before :each do
				@move = @cage.place_piece(:red,3)
			end

			it "puts piece on the bottom row in the correct column" do
				expect(@cage.row1).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row2).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row3).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row4).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row5).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row6).to eql "|    |    | #{RED}  |    |    |    |    |"
			end

			it "returns the coordinate of the newly-placed piece" do
				expect(@move).to eql [3,6]
			end

			it "puts piece on the bottom row in a different column" do
				@cage.place_piece(:black,5)
				expect(@cage.row1).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row2).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row3).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row4).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row5).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row6).to eql "|    |    | #{RED}  |    | #{BLACK}  |    |    |"
			end

			it "returns the coordinate of the newly-placed piece" do
				@move = @cage.place_piece(:black,5)
				expect(@move).to eql [5,6]
			end

		end

		context "when column has at least one piece" do

			before :each do
				@cage.place_piece(:red,3)
				@cage.place_piece(:black,5)
				@cage.place_piece(:red,3)
			end

			it "puts piece on the row above the bottom row in the correct column" do
				expect(@cage.row1).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row2).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row3).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row4).to eql "|    |    |    |    |    |    |    |"
				expect(@cage.row5).to eql "|    |    | #{RED}  |    |    |    |    |"
				expect(@cage.row6).to eql "|    |    | #{RED}  |    | #{BLACK}  |    |    |"
			end

			context "when another piece is placed in the same column" do
				it "puts piece on the row above that row in the correct column" do
					@cage.place_piece(:black,3)
					expect(@cage.row1).to eql "|    |    |    |    |    |    |    |"
					expect(@cage.row2).to eql "|    |    |    |    |    |    |    |"
					expect(@cage.row3).to eql "|    |    |    |    |    |    |    |"
					expect(@cage.row4).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row5).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@cage.row6).to eql "|    |    | #{RED}  |    | #{BLACK}  |    |    |"
				end
			end

		end

		context "when column is filled" do

			before do
				@cage.place_piece(:red,3)
				@cage.place_piece(:black,3)
				@cage.place_piece(:red,3)
				@cage.place_piece(:black,3)
				@cage.place_piece(:red,3)
				@cage.place_piece(:black,3)
			end

			context "when a piece is placed in the same column" do
				it "gives an error message and returns an error" do
					expect(STDOUT).to receive(:puts).with("Error: Column is full. Try again...")
					move = @cage.place_piece(:red,3)
					expect(@cage.row1).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row2).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@cage.row3).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row4).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@cage.row5).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row6).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(move).to eql :FullColumnError
				end
			end

			context "when a piece is placed in a different, open column" do
				it "places the piece in the correct spot" do
					move = @cage.place_piece(:red,5)
					expect(@cage.row1).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row2).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@cage.row3).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row4).to eql "|    |    | #{RED}  |    |    |    |    |"
					expect(@cage.row5).to eql "|    |    | #{BLACK}  |    |    |    |    |"
					expect(@cage.row6).to eql "|    |    | #{RED}  |    | #{RED}  |    |    |"
					expect(move).to eql [5,6]
				end
			end

		end

	end

end