class Cli

	def initialize rooms
		@rooms = rooms
		@inventory = {}
		@weight = 0
		@current_room = @rooms[:remote_island]
		puts "You were on a plane, and just crashed. You landed on a remote island and don't know where you are."
		puts
		@current_room.enter
	end

	def goto_room direction
		if @current_room.paths.has_key?(direction.to_sym)
			@current_room.leave
			@current_room = @current_room.paths[direction.to_sym]
			@current_room.enter
		else
			puts "You can't go that way".red
		end
	end

	# START CLI METHODS

	def get item
		if @current_room.item_exists item
			max_weight = 15 # Its very likely I'll change these values as more items are added to the game
			max_weight += 30 if @inventory.has_key? :backback
			item_weight = @current_room.get_item(item).weight
			if @weight + item_weight <= max_weight
				@weight += item_weight
				@inventory[item.to_sym] = @current_room[item]
				@current_room.remove_item item
				puts "You picked up #{item}!".magenta
			else
				puts "Carrying this item would make your load too heavy".red
			end
		else
			puts "That item is not in here, or can't be taken.".red
		end
	end

	alias_method :take, :get

	def inventory
		@inventory.each { |k, v|
			puts v.name
		}
	end

	alias_method :inv, :inventory
	alias_method :i, :inventory

	def look
		@current_room.look
	end

	def examine item
		if @inventory.has_key? item.to_sym
			puts @inventory[item.to_sym].examine
		else
			@current_room.look_item item
		end
	end

	alias_method :exam, :examine

	def drop item
		@weight -= @inventory[item.to_sym].weight
		@current_room[item] = @inventory[item.to_sym]
		@inventory.delete item.to_sym
	end

	def easter egg
		if egg == "egg"
			case Random.new.rand(0..1)
			when 0
				puts "And flying ice cream truck falls from the sky and kills you. Jk"
			else
				puts "bonjour! Où sont vos pantalons? J'aime la vie. la vie est un plaisir. tout comme ce match. PS4 est mieux que la Xbox un. i luv jeux. paix broseph."
			end
		end
	end

	def put item_1, in_item
		success = @inventory[item_1.to_sym].put @inventory[in_item.to_sym]
		@inventory.delete item_1.to_sym if success # not working but i may have fixed idk
	end

	def eat item
		inventory[item.to_sym].eat
	end

	def help
		puts "Some basic commands to get you started: n, e, s, w, ne, nw, se, sw".magenta
		puts "Those are directions if you didn't understand what any of dat means.".magenta
		puts "Many commands can be abbreviated or used by typing their first letter.".magenta
	end

	def quit
		exit
	end

	def shoot target
		if inventory.has_key? :pistol
			case target
			when "bear"
				if @current_room == @rooms[:jungle_n]
					@current_room.options[:bear_alive] = false
					@current_room.hidden_room.description = "Nothing here."
					puts "BANG! You kiled the bear"
				end
			end
		else
			puts "You don't have anything to shoot with."
		end
	end
end