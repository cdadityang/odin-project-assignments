# 1: Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.

def fibs(n)
  i, j = 0, 1
  (1..n).each do
    puts j
    k = i + j
    i, j = j, k
  end
end

fibs(5)
puts "-----"
puts ""

# -----

# 2: Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines.

def fibs_rec(n, arr = [0, 1])
  # return 0 if n == 0
  # return arr if n == 1 || arr.length > n
  # fibs_rec(n, (arr << (arr[-1] + arr[-2])))
  
  # One line sol
  n == 0 ? 0 : ((n == 1 || arr.length > n) ? arr : fibs_rec(n, (arr << (arr[-1] + arr[-2]))))
end

p fibs_rec(5)