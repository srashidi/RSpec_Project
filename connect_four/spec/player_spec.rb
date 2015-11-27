require 'spec_helper'

describe Player do

	before :each do
		@player = Player.new(:red)
	end

	describe "#new" do

		it "takes one parameter and returns a Player object" do
			expect(@player).to be_an_instance_of Player
		end

	end

	describe "#color" do

		it "returns the color of the Player object" do
			expect(@player.color).to eql :red
		end

		context "when set equal to a new color" do
			it "raises NoMethodError" do
				expect { @player.color = :black }.to raise_error(NoMethodError)
			end
		end

	end

	describe "#pieces" do

		context "when Player object is initialized" do
			it "returns an empty array" do
				expect(@player.pieces).to eql []
			end
		end

		context "when coordinate arrays are pushed to #pieces" do

			before do
				@player.pieces << [3,6]
				@player.pieces << [3,5]
				@player.pieces << [4,6]
			end

			it "returns an array with all coordinates pushed" do
				expect(@player.pieces).to eql [[3,6],[3,5],[4,6]]
			end
		end

	end

end