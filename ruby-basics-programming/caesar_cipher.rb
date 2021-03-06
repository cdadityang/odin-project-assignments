def caesar_cipher(str, shift)
  str1 = str.split("")
  str2 = []
  str1.each do |n|
    shift_total = n.ord + shift
    if shift_total > 90 and shift_total < 97
      str2 << (shift_total - 90 + 64).chr
    elsif shift_total > 122
      str2 << (shift_total - 122 + 96).chr
    elsif (shift_total > 64 and shift_total < 91) or (shift_total > 96 and shift_total < 123)
      str2 << shift_total.chr
    else
      str2 << n
    end
  end
  return str2.join("")
end

caesar_cipher("What a string!", 5)