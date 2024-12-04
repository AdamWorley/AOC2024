MATCH = "XMAS"

lines = File.readlines("input.txt")

matches = 0

lines.map { |x| x.strip }.each_with_index{|line, y|
  
  line.each_char.with_index{|_, x|
    # Match line
    matches += 1 if line[x..x+3] == MATCH || line[x..x+3].reverse == MATCH
    
    if(y < lines.size - 3)
      # Match Column
      column = [lines[y][x],lines[y+1][x],lines[y+2][x],lines[y+3][x]].join
      matches += 1 if column == MATCH || column.reverse == MATCH  
      
      # Match left right diagonal
      left_right = [lines[y][x],lines[y+1][x+1],lines[y+2][x+2],lines[y+3][x+3]].join
      matches += 1 if left_right == MATCH || left_right.reverse == MATCH 
      
      # Match right left diagonal
      right_left = [lines[y][x+3],lines[y+1][x+2],lines[y+2][x+1],lines[y+3][x]].join
      matches += 1 if right_left == MATCH || right_left.reverse == MATCH 
    end
  }
}

puts "Matches = #{matches}"