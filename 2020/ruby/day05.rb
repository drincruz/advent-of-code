# Advent of Code 2020: Day 05
# Take the input list of boarding passes,
# translate them to their row, col to get their seat ID
# and get the max seat ID.
# NOTES
# - 128 rows in plane
# - 8 seats per row
# Part 2
#  - find my seat
#  - my seat will be missing from the list
#  - fill the matrix (airplane seats)
#  - then find a row that is missing a boarding pass (my seat)
#  - very "front", very "back" seats may be missing
#  - we just want to find the missing integer in the "middle"
#  - we are searching for the point where |arr[index+1] - arr[index]| > 1

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def binary_row(boarding_pass)
  # Example boarding pass:
  # BBFFBBFLRL
  left = 0
  right = 127
  mid = (left + right) / 2
  i = 0

  while left <= right && i < 7
    if boarding_pass[i] == 'F'
      right = mid
    else
      left = mid + 1
    end

    mid = (left + right) / 2
    i += 1
  end

  mid
end

def binary_col(boarding_pass)
  # Example boarding pass:
  # BBFFBBFLRL
  left = 0
  right = 7
  mid = (left + right) / 2
  i = 7

  while left <= right && i < 10
    if boarding_pass[i] == 'L'
      right = mid
    else
      left = mid + 1
    end

    mid = (left + right) / 2
    i += 1
  end

  mid
end

def read_boarding_passes
  # Every seat also has a unique seat ID:
  # multiply the row by 8, then add the column.
  boarding_passes = read_file('day05.txt')

  sorted_boarding_passes = boarding_passes.map do |pass|
    binary_row(pass) * 8 + binary_col(pass)
  end.sort

  i = 0
  while i < sorted_boarding_passes.length - 1
    left = sorted_boarding_passes[i]
    right = sorted_boarding_passes[i + 1]
    # We will print out the numbers where the difference is greater than 1.
    puts "#{left}, #{right}" if right - left > 1

    i += 1
  end
end

puts read_boarding_passes
