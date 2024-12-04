left = []
right = []

File.open("input.txt", "r") do |f|
  f.each_line.with_index do |line,idx|
    l = line.split("\s")

    left[idx] = Integer(l[0])
    right[idx] = Integer(l[1])
  end
end

left_sorted = left.sort()
right_sorted = right.sort()

total = 0

left_sorted.each_with_index {|val, index| 
# puts "#{val} - #{right_sorted[index]} = #{(val - right_sorted[index]).abs() }"
total += (val - right_sorted[index]).abs() 
}

puts total
