require "game"
require "board"
require "player"

#check to see if token can be placed in correct location
describe Board do
	before :each do
		@board = Board.new
		@player1 = Player.new("Alex", "\u26AB")
		@player2 = Player.new("Bob", "\u26AA")
	end

	describe "#place_piece" do
		context "given a column" do
			it "places piece on bottom if there isn't a piece there" do
				@board.place_piece(0,@player1)
				expect(@board.a).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[@player1.token," "," "," "," "," "," "]])
			end

			it "places piece on top of previous piece" do
				@board.place_piece(1, @player1)
				@board.place_piece(1, @player2)
				expect(@board.a).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" ",@player2.token," "," "," "," "," "],[" ",@player1.token," "," "," "," "," "]])
			end
		end
	end

	describe "#valid?" do
		context "when given a column that is full" do
			it "returns false" do
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				expect(@board.valid?(0)).to eql(false)
			end
		end

		context "when given a number that is not an integer between 0 and 6 inclusive" do
			it "returns false" do
				expect(@board.valid?(0.5)).to eql(false)
			end
		end
	end

	describe "#horizontal_win" do
		context "when given four identical pieces in a row horizontally" do
			it "returns true" do 
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(3,@player1)
				expect(@board.horizontal_win(@player1.history.last, @player1)).to eql(true)
			end
		end
	end

	describe "#vertical_win" do 
		context "when given four identical pieces vertically" do 
			it "returns true" do
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(3,@player2)
				@board.place_piece(0,@player1)
				expect(@board.vertical_win(@player1.history.last, @player1)).to eql(true)
			end
		end
	end

	describe "#upward_diagonal_win" do
		context "when four diagonal pieces upwards" do 
			it "returns true" do
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(3,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(3,@player1)
				@board.place_piece(3,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(4,@player2)
				@board.place_piece(3,@player1)
				expect(@board.upward_diagonal_win(@player1.history.last, @player1)). to eql(true)
			end
		end
	end

	describe "#downward_diagonal_win" do
		context "when dour diagonal pieces downards" do
			it "returns true" do
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(5,@player2)
				@board.place_piece(3,@player1)
				expect(@board.downward_diagonal_win(@player1.history.last, @player1)). to eql(true)
			end
		end
	end

	describe ".tie?" do
		context "when the board is not full" do
			it "returns false" do
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(5,@player2)
				@board.place_piece(3,@player1)
				expect(@board.tie?).to eql(false)
			end
		end

		context "when the board is full" do 
			it "returns true" do 
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(0,@player1)
				@board.place_piece(0,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(1,@player1)
				@board.place_piece(1,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(2,@player1)
				@board.place_piece(2,@player2)
				@board.place_piece(3,@player1)
				@board.place_piece(3,@player2)
				@board.place_piece(3,@player1)
				@board.place_piece(3,@player2)
				@board.place_piece(3,@player1)
				@board.place_piece(3,@player2)
				@board.place_piece(4,@player1)
				@board.place_piece(4,@player2)
				@board.place_piece(4,@player1)
				@board.place_piece(4,@player2)
				@board.place_piece(4,@player1)
				@board.place_piece(4,@player2)
				@board.place_piece(5,@player1)
				@board.place_piece(5,@player2)
				@board.place_piece(5,@player1)
				@board.place_piece(5,@player2)
				@board.place_piece(5,@player1)
				@board.place_piece(5,@player2)
				@board.place_piece(6,@player1)
				@board.place_piece(6,@player2)
				@board.place_piece(6,@player1)
				@board.place_piece(6,@player2)
				@board.place_piece(6,@player1)
				@board.place_piece(6,@player2)
				expect(@board.tie?).to eql(true)
			end
		end
	end
end





