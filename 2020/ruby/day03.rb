# Advent of Code 2020: Day 03

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def traverse(row, current, count)
  # Sample rows
  # .........#..##.##..............
  # #...#.#..#.....................
  count += 1 if row[current] == '#'
  current += 3
  current -= row.length if current >= row.length

  [current, count]
end

def traverse_map
  tree_map = read_file('day03.txt')

  row = 0
  current = 0
  count = 0
  while row < tree_map.length
    current, count = traverse(tree_map[row], current, count)
    row += 1
  end

  count
end

puts traverse_map
