input = File.readlines('input.txt').map do |line|
  line.chars
end

width = input[0].size
height = input.size

flattened = input.flatten.join
guard_start = flattened.chars.find_index("^")

x = guard_start % width
y = (guard_start / height) - 1

guard_pos = [x,y]
p "start at #{guard_pos}"

module Direction
  NORTH = [0,-1]
  EAST = [1,0]
  SOUTH = [0,1]
  WEST = [-1,0]
end

direction = Direction::NORTH

visited = [guard_pos]

while x < width && x > 0 && y < height && y > 0
  case direction
    when Direction::NORTH
      if input.fetch(y-1,[])[x] == "#"
        p "obstruction to the north"
        direction = Direction::EAST
      end
    when Direction::EAST
      if input.fetch(y,[])[x+1] == "#"
        p "obstruction to the east"
        direction = Direction::SOUTH
      end
    when Direction::SOUTH
      if input.fetch(y+1,[])[x] == "#"
        p "obstruction to the south"
        direction = Direction::WEST
      end
    when Direction::WEST
      if input.fetch(y,[])[x-1] == "#"
        p "obstruction to the west"
        direction = Direction::NORTH
      end
    else
      abort("The guard is lost")
  end

  #Move guard and track position
  x = guard_pos[0]+=direction[0]
  y = guard_pos[1]+=direction[1]
  guard_pos = [x,y]
  visited = visited.push(guard_pos)
end

p visited.uniq.size