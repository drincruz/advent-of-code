# Advent of Code 2020: Day 03

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def traverse(row, current, step, count)
  # Sample rows
  # .........#..##.##..............
  # #...#.#..#.....................
  count += 1 if row[current] == '#'
  current += step
  current -= row.length if current >= row.length

  [current, count]
end

def traverse_map(step, row_step)
  tree_map = read_file('day03.txt')

  row = 0
  current = 0
  count = 0
  while row < tree_map.length
    current, count = traverse(tree_map[row], current, step, count)
    row += row_step
  end

  count
end

def main
  steps = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

  steps.map { |step, row_step| traverse_map(step, row_step) }.reduce(1, :*)
end

puts main
