## Comparing Rocks with Code
### Loop:
start_time1 = Time.now

# make some random rocks
rocks = 30.times.map{rand(200) + 1}
puts rocks.join(', ')
max_rock = 0

rocks.each do |rock|
  max_rock = rock if max_rock < rock 
end

puts "Heaviest rock is: #{max_rock}"

# or with inject
# puts "Heaviest rock is: #{rocks.inject{|max_rock, rock| max_rock > rock ? max_rock : rock}}"

puts "Time1: #{(Time.now - start_time1) * 1000} s"

### Recursion way:
start_time2 = Time.now

def rock_judger(rocks_arr)    
    if rocks_arr.length <= 2  # the base case
      a = rocks_arr[0]
      b = rocks_arr[-1]
    else
      a = rock_judger(rocks_arr.slice!(0,rocks_arr.length/2))
      b = rock_judger(rocks_arr)
    end    
    
    return a > b ? a : b
end

rocks = 30.times.map{rand(200) + 1}
puts rocks.join(', ')
puts "Heaviest rock is: #{rock_judger(rocks)}"

puts "Time2: #{(Time.now - start_time2) * 1000} s"