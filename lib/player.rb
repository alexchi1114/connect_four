class Player
	attr_accessor :name, :token,:history
	def initialize(name, token)
		@name = name
		@token = token
		@history = []
	end
end
	