class Book
	attr_accessor :title

	def title=(new_title)
		words = new_title.split(" ")
		ele = []
		lw = ["a","an","and","the","in","of"]
		words.each do |word|
			if lw.include? word
				tem = word
			else
				tem = word.capitalize
			end
			ele << tem
		end
		if lw.include? words[0]
			words[0].capitalize!
		end
		@title = ele.join(" ")
	end
end
