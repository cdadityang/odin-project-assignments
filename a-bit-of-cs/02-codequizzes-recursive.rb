# 1: Define a recursive function that finds the factorial of a number.
def factorial(n)
  return 1 if n == 0
  factorial(n-1) * n
end

puts factorial(5) # 120
puts "-----"
puts ""

# -----

# 2: Define a recursive function that returns true if a string is a palindrome and false otherwise
def palindrome(str)
  if str.length == 1 || str.length == 0
    true
  else
    if str[0] == str[-1]
      palindrome(str[1..-2])
    else
      false
    end
  end
end

puts palindrome("madam")
puts "-----"
puts ""

# -----

# 3: Define a recursive function that takes an argument n and prints "n bottles of beer on the wall", "(n-1) bottles of beer on the wall", ..., "no more bottles of beer on the wall".

def print_wall(n)
  if n == 0
    puts "no more bottles of beer on the wall" 
  else
    puts "#{n} bottles of beer on the wall"
    print_wall(n-1)
  end
end

print_wall(2)
puts "-----"
puts ""

# -----

# 4: Define a recursive function that takes an argument n and returns the fibonacci value of that position. The fibonacci sequence is 0, 1, 1, 2, 3, 5, 8, 13, 21... So fib(5) should return 5 and fib(6) should return 8.

def fib(n)
  if n == 0
    0
  elsif n == 1
    1
  else
    fib(n-1) + fib(n-2)
  end
end

p fib(5)
puts "-----"
puts ""

# -----

# 5: Define a recursive function that flattens an array. The method should convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] to [1, 8, 9, 3, 4].

def flatten(arr, result = [])
  arr.each do |ele|
    if ele.class == Array
      flatten(ele, result)
    else
      result << ele
    end
  end
  result
end

p flatten([[1, [8, 9]], [3, 4]])

puts "-----"
puts ""

# -----

# 6: Use the roman_mapping hash to define a recursive method that converts an integer to a Roman numeral.

roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

def itor(roman_mapping, number, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return itor(roman_mapping, modulus, result) if quotient > 0
  end
end

p itor(roman_mapping, 54)

# -----

# 7: Use the roman_mapping hash to define a recursive method that converts a Roman numeral to an integer.

roman_mapping1 = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def rtoi(roman_mapping, str, result = 0)
  return result if str.empty?
  roman_mapping.keys.each do |roman|
    if str.start_with?(roman)
      result += roman_mapping[roman]
      str = str.slice(roman.length, str.length)
      return rtoi(roman_mapping, str, result)
    end
  end
end

p rtoi(roman_mapping1, "MLIV")