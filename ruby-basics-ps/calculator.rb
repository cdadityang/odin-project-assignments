def add(n1,n2)
	return n1+n2
end

def subtract(n1, n2)
	return n1-n2
end

def sum(n1)
	sums=0;
	n1.each do |add|
		sums = sums + add
	end
	return sums
end

def multiply(n1,n2)
	return n1*n2
end

def multiplyseveral(n1)
	mulsum = 1
	n1.each do |mul|
		mulsum = mulsum*mul
	end
	return mulsum
end

def power(n1,n2)
	return n1**n2
end

def factorial(n1)
	total = 1
	(1..n1).each do |num|
		total = total*num
	end
	return total
end