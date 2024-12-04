left = []
right = []

File.open("input.txt", "r") do |f|
  f.each_line.with_index do |line,idx|
    l = line.split("\s")

    left[idx] = Integer(l[0])
    right[idx] = Integer(l[1])
  end
end

left_sorted = left.sort
right_tally = right.tally

total = 0

left_sorted.each_with_index {|val, index| 
puts "#{val} x #{right_tally.fetch(val, 0)} = #{(val - right_tally.fetch(val, 0))  }"
total += (val * right_tally.fetch(val, 0))
}

puts total
