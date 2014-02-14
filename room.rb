class Room

	attr_accessor :items, :paths

	def initialize name, description, items
		@name = name
		@description = description
		@items = items
		@visited = false
	end

	def enter
		puts @name
		puts @description unless @visited
		@visited = true
	end
	
	def get_item i
		self.items[i.to_sym]
	end

	def look
		puts @name
		puts @description
	end

	def item_exists i
		@items.has_key? i.to_sym
	end

	def add_item i
		@items << i
	end

	def remove_item i
		@items.delete i.to_sym
	end

	def set_paths paths
		@paths = paths
	end
end