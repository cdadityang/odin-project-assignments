def substrings(str, arr)
  final = Hash.new(0)
  arr1 = str.split(' ')
  arr1.length.times do |n| # n = index
    arr.each do |m| # m = item
      if arr1[n].downcase.include?(m)
        final[m] += 1
      end
    end
  end
  final
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)

puts substrings("below", dictionary)
