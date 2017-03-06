require_relative "player"
require_relative "board"

class Game
	attr_accessor :players, :turn, :p1, :p2, :current_player, :board
	def initialize
		@turn = 0
		@current_player = nil
		@board = Board.new
		intro
	end

	def intro 
		puts "Welcome to Connect Four!"
		puts "what is player 1's name?"
		@p1 = Player.new(gets.chomp, "\u26AB")
		puts "what is player 2's name?"
		@p2 = Player.new(gets.chomp, "\u26AA")
		play
	end

	def play	
		while @turn < 42
			@turn%2==0 ? @current_player = @p1 : @current_player = @p2
			win = false
			@board.print_board
			puts "#{@current_player.name}'s turn: Which column would you like to drop your chip into?"
			column = gets.chomp.to_i 
			until @board.valid?(column)==true
				puts "not a valid selection"
				column = gets.chomp.to_i
			end
			@board.place_piece(column, @current_player)
			if @board.vertical_win(@current_player.history.last, @current_player) == true
				win = true
			elsif @board.horizontal_win(@current_player.history.last, @current_player) == true
				win = true
			elsif @board.upward_diagonal_win(@current_player.history.last, @current_player) == true
				win = true
			elsif @board.downward_diagonal_win(@current_player.history.last, @current_player) == true
				win = true
			elsif @board.tie? == true
				puts "It's a tie"
				@board.print_board
			end
			if win == true
				@board.print_board
				puts "#{@current_player.name} won!"
				@turn = 42
			end
			@turn +=1
		end
	end
end
Game.new



