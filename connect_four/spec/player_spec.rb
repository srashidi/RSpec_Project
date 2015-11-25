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

end