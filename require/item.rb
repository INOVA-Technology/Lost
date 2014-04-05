class Item

	attr_accessor :name, :examine, :weight, :options

	def initialize name, examine, weight, options={}
		@name = name
		@examine = examine
		@weight = weight
		@options = options
		@options[:hidden] ||= false
	end

	def put in_item
		case @name
		when "Batteries"
			if in_item.name == "Radio"
				in_item.options[:power] == true
				puts "You put batteries in the radio, and turn it on. You hear a strange message in French looping over and over."
				puts "The message is: Je crois que j'ai quitté ma vie à la maison".magenta
				in_item.set_examine "Manufactured by INOVA Electronics. It is in good condition. You hear a strange message in French looping over and over."
				return true
			end
		end
		puts "You can't do that.".red
		return false
	end

	def set_examine e
		@examine = e
	end

	def hidden
		@options[:hidden]
	end

	def unhide
		@options[:hidden] = false
	end

	def eat a
		if @options[:kill] == true
			puts "You forcefully shoved a #{a} down your throat.  This made you die. LOL Y U DO DAT?".red
			exit
		elsif @option[:kill] == false
			puts "YUMMY YUMMY! You just ate the #{a}!".cyan
		else
			puts "Hmmm... Don't think you can fit that in your mouth..."
		end
	end

end