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

	attr_accessor :items, :paths

	def initialize name, description, items={}
		@name = name
		@description = description
		@items = items
		@visited = false
	end

	def enter
		puts @name
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
		puts "There is #{_items.to_sentence} in this room."

	end
	
	def get_item i
		self.items[i.to_sym]
	end

	def look
		puts @name
		self.describe
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