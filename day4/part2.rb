MATCH = "MAS"

lines = File.readlines("input.txt")

matches = 0

lines.map { |x| x.strip }.each_with_index{|line, y|
  line.each_char.with_index{|_, x|

    if(y < lines.size - 2)
      # Match left right diagonal
      left_right = [lines[y][x],lines[y+1][x+1],lines[y+2][x+2]].join
      left_right_match = left_right == MATCH || left_right.reverse == MATCH 
      
      # Match right left diagonal
      right_left = [lines[y][x+2],lines[y+1][x+1],lines[y+2][x]].join
      right_left_match = right_left == MATCH || right_left.reverse == MATCH 
      
      matches += 1 if left_right_match && right_left_match
    end
  }
}

puts "Matches = #{matches}"