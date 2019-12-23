def echo(str1)
	return str1
end

def shout(str1)
	return str1.upcase
end

def repeat(str1, times = 2)
	return ([str1] * times).join(" ")
end

def start_of_word(str1, num)
	arr1 = str1.split("")
	arr2 = []
	anum = 0
	while(anum < num)
		arr2 << arr1[anum]
		anum = anum+1
	end
	return arr2.join("")
end

def first_word(str1)
	return str1.split(" ").first
end

def titleize(str1)
	arr1 = []
	str1.split(" ").each do |caps|
		if(caps == "and" || caps == "over" || caps == "the")
			arr1 << caps
		else
			arr1 << caps.capitalize
		end
	end
	arr1.first.capitalize!
	return arr1.join(" ")
end