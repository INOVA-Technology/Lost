class Item

	attr_accessor :name, :examine, :weight, :hidden

	def initialize name, examine, weight, hidden=false
		@name = name
		@examine = examine
		@weight = weight
		@hidden = hidden
	end

end