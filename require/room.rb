class Array
  def to_sentence
    default_words_connector     = ", "
    default_two_words_connector = " and "
    default_last_word_connector = ", and "

    case length
      when 0
        ""
      when 1
        self[0].to_s.dup
      when 2
        "#{self[0]}#{default_two_words_connector}#{self[1]}"
      else
        "#{self[0...-1].join(default_words_connector)}#{default_last_word_connector}#{self[-1]}"
    end
  end
end

class Room

	attr_accessor :name, :description, :items, :options, :paths, :hidden_room

	def initialize name, description, items={}, options={}
		@name = name
		@description = description
		@items = items
		@options = options
		@visited = false
	end

	def enter
		puts @name.cyan
		self.describe unless @visited
		@visited = true
	end

	def describe
		puts @description
		_items = []
		@items.each_pair { |k, v|
			next if v.hidden
			item = v.name
			a_or_an = ["a", "e", "i", "o", "u"].include?(item[0].downcase) ? "an" : "a"
			_items << "#{a_or_an} #{item}"
		}
		return if _items.empty?
		puts "There is #{_items.to_sentence} here."
	end
	
	def [] i
		self.items[i.to_sym]
	end

	alias_method :get_item, :[]

	def look
		puts @name.cyan
		self.describe
	end

	def look_item i
		if @hidden_room
			if @hidden_room.name.downcase == i
				puts @hidden_room.description
				_items = []
				@items.each_pair { |k, v|
					next unless v.options.hidden
					item = v.name
					a_or_an = ["a", "e", "i", "o", "u"].include?(item[0].downcase) ? "an" : "a"
					_items << "#{a_or_an} #{item}"
				}
				return if _items.empty?
				puts "There is #{_items.to_sentence} here."
			else
				puts "That item is not here.".red
			end
		else
			puts "That item is not in here.".red
		end
	end

	def item_exists i
		@items.has_key? i.to_sym
	end

	def []= key, item
		@items[key.to_sym] = item
		@items[key.to_sym].unhide
	end

	alias_method :add_item, :[]=

	def remove_item i
		@items.delete i.to_sym
	end

	def set_paths paths
		@paths = paths
	end

	def set_hidden_room room
		@hidden_room = room
	end

	def leave

		case self.name
		when "Jungle North"
			if @options[:bear_alive]
				puts "A bear comes out of the trees and eats you. You are now dead"
				exit 1 # add acually function for dying
			end
		end

	end
end