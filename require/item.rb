class Item

	attr_accessor :name, :examine, :weight, :hidden, :options

	def initialize name, examine, weight, hidden=false, options={}
		@name = name
		@examine = examine
		@weight = weight
		@hidden = hidden
		@options = options
	end

	def put _item
		i = _item.name
		case @name
		when "Batteries"
			if i == "Radio"
				_item.options[:power] == true
				puts "You put batterys in the radio, and turn it on. You hear a strange message in French looping over and over."
				puts "The message is: Je crois que j'ai quitté ma vie à la maison".magenta
				_item.set_examine "Manufactured by INOVA Electronics. It is in good condition. You hear a strange message in French looping over and over."
				return true
			end
		end
		puts "You can't do that.".red
		return false
	end

	def set_examine e
		@examine = e
	end

	def unhide
		@hidden = false
	end

end