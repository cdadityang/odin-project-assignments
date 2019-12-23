module Enumerable
  # Moves through all elements in array and performs operation like .each method
  def my_each
    for i in self
      yield i
    end
  end

  # It is same as above, but includes index also.
  def my_each_with_index
    for i in self
      a = self.find_index(i)
      yield i, a
    end
  end

  # Returns an array only if the element satisfy the condition in the block
  def my_select
    select = []
    self.my_each do |e|
      select.push(e) if yield(e)
    end
    select
  end

  # Does all the elements match the condition given in block? Even if one doesn't it will give false
  def my_all?
    self.my_each do |e|
      return false if !(yield(e))
    end
    true
  end

  # If any one element of array is true for block, it will give true.
  def my_any?
    self.my_each do |e|
      return true if yield(e)
    end
    false
  end

  # If all the elements doesn't satisfy the block condition, it will return true.
  def my_none?
    self.my_each do |e|
      return false if yield(e)
    end
    true
  end

  # Counts the elements of an array
  def my_count
    count = 0
    self.my_each do |e|
      count += 1
    end
    count
  end

  # It will run the operation to each array element and returns the same no. of array
  def my_map
    map = []
    self.my_each do |e|
      a = yield(e)
      map << a
    end
    map
  end

  # Inject will take a parameter which it will store as accumulator to result. i.e at beginning result = parameter value. Then it will do block operation and updates this result in the next run element. So at last it will return this final result.
  def my_inject(n=0)
    res = n # default value for result
    self.my_each do |e|
      res = yield(res, e)
    end
    res
  end
end

# [1,2,3].my_each {|n| puts n}
# {a: 4, b: 2, c: 3}.my_each {|k, v| puts v}

# [4,5,6].my_each_with_index {|v, i| puts i}

# [1,2,3,4].my_select {|v| v < 3}

# [1,2,3,4].my_any? {|n| n > 4}

# [1,2,3,4].my_none? {|n| n > 3}

# [1,2].my_count

# [1,2,3].my_map {|n| n * 3}

=begin
def multiply_els(arr)
  arr.my_inject(1) {|p, e| p * e}
end
p multiply_els([2,4,5])
=end