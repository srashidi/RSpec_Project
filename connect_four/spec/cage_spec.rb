require 'spec_helper'

RED = "\u{1F534}"
BLACK = "\u{2b24}"

describe Cage do

	before :all do
		@cage = Cage.new
	end

	describe "#new" do
		it "creates a new cage with no pieces" do
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
			expect(STDOUT).to receive(:puts).with(@cage.row1)
			expect(STDOUT).to receive(:puts).with(@cage.row2)
			expect(STDOUT).to receive(:puts).with(@cage.row3)
			expect(STDOUT).to receive(:puts).with(@cage.row4)
			expect(STDOUT).to receive(:puts).with(@cage.row5)
			expect(STDOUT).to receive(:puts).with(@cage.row6)
			@cage.display
		end

	end

	describe "#place_piece" do

		before :each do
			@cage.place_piece(:red,3)
		end

		context "when column is empty" do
			it "puts piece on the bottom row in the correct column" do
				expect(@cage.row6).to eql "|    |    | #{RED}  |    |    |    |    |"
			end
		end

	end

end