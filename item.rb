class Item

	attr_accessor :name, :exam, :weight

	def initialize name, exam, weight, hidden=false
		@name = name
		@exam = exam
		@weight = weight
		@hidden = hidden
	end

end