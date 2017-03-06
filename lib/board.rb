class Board
	attr_accessor :a
	def initialize
		@a = [[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "]]
		@column_counter = [0,0,0,0,0,0,0]
	end

	def print_board
		puts "| 0 | 1 | 2 | 3 | 4 | 5 | 6 |"
		puts "-----------------------------"
		puts "| #{@a[0][0]} | #{@a[0][1]} | #{@a[0][2]} | #{@a[0][3]} | #{@a[0][4]} | #{@a[0][5]} | #{@a[0][6]} |"
		puts "| #{@a[1][0]} | #{@a[1][1]} | #{@a[1][2]} | #{@a[1][3]} | #{@a[1][4]} | #{@a[1][5]} | #{@a[1][6]} |"
		puts "| #{@a[2][0]} | #{@a[2][1]} | #{@a[2][2]} | #{@a[2][3]} | #{@a[2][4]} | #{@a[2][5]} | #{@a[2][6]} |"
		puts "| #{@a[3][0]} | #{@a[3][1]} | #{@a[3][2]} | #{@a[3][3]} | #{@a[3][4]} | #{@a[3][5]} | #{@a[3][6]} |"
		puts "| #{@a[4][0]} | #{@a[4][1]} | #{@a[4][2]} | #{@a[4][3]} | #{@a[4][4]} | #{@a[4][5]} | #{@a[4][6]} |"
		puts "| #{@a[5][0]} | #{@a[5][1]} | #{@a[5][2]} | #{@a[5][3]} | #{@a[5][4]} | #{@a[5][5]} | #{@a[5][6]} |"
		puts "-----------------------------"
	end

	def valid?(num)
		possible = [0,1,2,3,4,5,6]
		valid = true
		if possible.include?(num)==false
			valid = false
		elsif self.a[0][num]!=" "
			valid = false
		end
		valid
	end

	def place_piece(column, player)
		row = 5 - @column_counter[column]
		@a[row][column] = player.token
		@column_counter[column]+=1
		player.history << [row, column]
	end

	def vertical_win(last_piece, player)
		row = last_piece[0]
		column = last_piece[1]
		token = player.token
		counter = 0
		search = true
		win = false
		x = row
		while search == true && x<=5
			if @a[x][column] == token
				counter +=1
				x+=1
			else
				search = false
			end

			if counter == 4
				win = true
				search = false
			end
		end
		win
	end

	def horizontal_win(last_piece, player)
		row = last_piece[0]
		column = last_piece[1]
		token = player.token
		counter = 1
		left_search = true
		right_search = true
		win = false
		y = column
		y1 = column + 1
		left = 0
		right = 0
		while left_search == true && y>=0
			if @a[row][y] == token
				left+=1
				y-=1
			else 
				left_search = false
			end
		end
		
		while right_search == true && y1<=6
			if @a[row][y1] == token
				right+=1
				y1-=1
			else 
				right_search = false
			end
		end

		if (left+right)>=4
			win=true
		end
		win
	end

	def upward_diagonal_win(last_piece, player)
		row = last_piece[0]
		column = last_piece[1]
		x = last_piece[0]
		y = last_piece[1]
		token = player.token
		win = false
		up_search = true
		down_search = true
		up_count = 1
		down_count = 0

		while up_search == true && row>0 && column <6
			if @a[row-1][column+1] == token
				up_count+=1
				row-=1
				column+=1
			else
				up_search = false
			end
		end

		while down_search == true && x<5 && column>0
			if @a[x+1][y-1] == token
				down_count+=1
				x+=1
				y-=1
			else
				down_search = false
			end
		end

		if (up_count+down_count)>=4
			win = true
		end
		win
	end

	def downward_diagonal_win(last_piece, player)
		row = last_piece[0]
		column = last_piece[1]
		x = last_piece[0]
		y = last_piece[1]
		token = player.token
		win = false
		up_search = true
		down_search = true
		up_count = 1
		down_count = 0

		while up_search == true && row>0 && column >0
			if @a[row-1][column-1] == token
				up_count+=1
				row-=1
				column-=1
			else
				up_search = false
			end
		end

		while down_search == true && x<5 && column<6
			if @a[x+1][y+1] == token
				down_count+=1
				x+=1
				y+=1
			else
				down_search = false
			end
		end

		if (up_count+down_count)>=4
			win = true
		end
		win
	end

	def tie?
		full = true
		@a.each do |row|
			if row.include?(" ")
				full = false
			end
		end
		full
	end
end

