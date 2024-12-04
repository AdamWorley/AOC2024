string = File.read("input.txt")

regex = /mul\((\d+),(\d+)\)/

toDo = string.split("do()").map {|s| s.split("don't")[0]}

matches = toDo.flat_map{|s| s.scan(regex).map {|l, r| 
    mul = l.to_i * r.to_i
    # puts "#{l} x #{r} = #{mul}" 
    mul
}
}

puts matches.sum
