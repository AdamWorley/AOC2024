string = File.read("input.txt")

regex = /mul\((\d+),(\d+)\)/

matches = string.scan(regex).map {|l, r| 
  mul = l.to_i * r.to_i
  # puts "#{l} x #{r} = #{mul}" 
  mul
}

puts matches.sum
