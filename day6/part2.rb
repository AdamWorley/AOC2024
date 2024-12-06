input = File.readlines('input.txt').map do |line|
  line.strip.chars
end

width = input[0].size
height = input.size

flattened = input.flatten.join

module Direction
  NORTH = [0, -1]
  EAST = [1, 0]
  SOUTH = [0, 1]
  WEST = [-1, 0]
end

caught = 0

input.each_with_index do |line, sy|
  line.each_with_index do |_, sx|
    guard_start = flattened.chars.find_index("^")

    x = guard_start % width
    y = guard_start / width
    guard_pos = [x, y]
    direction = Direction::NORTH

    # p "placing obstruction at #{[sy,sx]}"

    # Skip existing obstructions or guard
    if input[sy][sx] == "#"
      # p "skip existing obstruction at #{[sy, sx]}"
      next
    end

    if [sx, sy] == guard_pos
      # p "don't touch the guard"
      next
    end

    visited = {}
    visited["#{guard_pos[0]},#{guard_pos[1]}:#{direction}"] = true
    butterfly = input.map(&:dup)
    butterfly[sy][sx] = "#"

    while x >= 0 && x < width && y >= 0 && y < height
      case direction
      when Direction::NORTH
        if butterfly.fetch(y - 1, [])[x] == "#"
          # p "obstruction to the north"
          direction = Direction::EAST
        end
      when Direction::EAST
        if butterfly.fetch(y, [])[x + 1] == "#"
          # p "obstruction to the east"
          direction = Direction::SOUTH
        end
      when Direction::SOUTH
        if butterfly.fetch(y + 1, [])[x] == "#"
          # p "obstruction to the south"
          direction = Direction::WEST
        end
      when Direction::WEST
        if butterfly.fetch(y, [])[x - 1] == "#"
          # p "obstruction to the west"
          direction = Direction::NORTH
        end
      else
        abort("The guard is lost")
      end

      # Move guard
      x = guard_pos[0]+=direction[0]
      y = guard_pos[1]+=direction[1]
      guard_pos = [x,y]

      # Check for cycles
      check = "#{guard_pos[0]},#{guard_pos[1]}:#{direction}"
      if visited[check]
        p "Caught a loop with: #{[sy,sx]}"
        caught += 1
        break
      end
      visited[check] = true

      if visited.size > width * height
        abort("Infinite loop detected!")
      end
    end
  end
end

# 1518 too low
p caught
