# 2020: Day11
# Part 1
# Count the number of occupied seats after five runs of the following rules.
# The following rules are applied to every seat simultaneously:
#
# If a seat is empty (L) and there are no occupied seats adjacent to it,
# the seat becomes occupied.
# If a seat is occupied (#) and four or more seats adjacent to it are also
# occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.

require_relative './utils'

# Day11
class Day11
  include Utils

  def seats
    read_file('day11.txt')
  end

  def empty?(space)
    space == 'L'
  end

  def occupied?(space)
    space == '#'
  end

  def floor?(space)
    space == '.'
  end

  def valid_row?(seats, row)
    row.between?(0, seats.length - 1)
  end

  def valid_col?(seats, col)
    col.between?(0, seats[0].length - 1)
  end

  def occupied_adjacent_seats(seats, seat)
    # we consider "adjacent" as up, down, left, right, and diagonal
    row, col = seat
    count = 0
    if valid_row?(seats, row - 1)
      count += 1 if occupied?(seats[row - 1][col])
      if valid_col?(seats, col - 1)
        count += 1 if occupied?(seats[row - 1][col - 1])
      end
      if valid_col?(seats, col + 1)
        count += 1 if occupied?(seats[row - 1][col + 1])
      end
    end

    count += 1 if occupied?(seats[row][col - 1]) && valid_col?(seats, col - 1)
    count += 1 if occupied?(seats[row][col + 1]) && valid_col?(seats, col + 1)

    if valid_row?(seats, row + 1)
      count += 1 if occupied?(seats[row + 1][col])
      if valid_col?(seats, col - 1)
        count += 1 if occupied?(seats[row + 1][col - 1])
      end
      if valid_col?(seats, col + 1)
        count += 1 if occupied?(seats[row + 1][col + 1])
      end
    end

    count.positive? ? count : 0
  end

  def left_row_occupied_count(seats, seat)
    row, col = seat
    left = col
    count = 0

    while left.positive?
      break unless valid_col?(seats, left)
      break if occupied?(seats[row][left])

      count += 1
      left -= 1
    end

    count
  end

  def right_row_occupied_count(seats, seat)
    row, col = seat
    right = col
    count = 0

    while right < seats[0].length
      break unless valid_col?(seats, right)
      break if occupied?(seats[row][right])

      count += 1
      right += 1
    end

    count
  end

  def up_col_occupied_count(seats, seat)
    row, col = seat
    up = row
    count = 0

    while up.positive?
      break unless valid_row?(seats, up)
      break if occupied?(seats[up][col])

      count += 1
      up -= 1
    end

    count
  end

  def down_col_occupied_count(seats, seat)
    row, col = seat
    down = row
    count = 0

    while down < seats.length
      break unless valid_row?(seats, down)
      break if occupied?(seats[down][col])

      count += 1
      down += 1
    end

    count
  end

  def first_occupied_seats(seats, seat)
    count = 0

    count += left_row_occupied_count(seats, seat)
    count += right_row_occupied_count(seats, seat)
    count += up_col_occupied_count(seats, seat)
    count += down_col_occupied_count(seats, seat)

    count
  end

  def copy_seat_layout(seat_layout)
    new_layout = Array.new(seat_layout.length) do
      Array.new(seat_layout[0].length)
    end
    (0..seat_layout.length - 1).each do |row|
      (0..seat_layout[0].length - 1).each do |col|
        new_layout[row][col] = seat_layout[row][col]
      end
    end

    new_layout
  end

  def next_state(seat_layout)
    next_layout = copy_seat_layout(seat_layout)

    (0..seat_layout.length - 1).each do |row|
      (0..seat_layout[0].length - 1).each do |col|
        occupied_count = first_occupied_seats(seat_layout, [row, col])
        if occupied_count.zero? && empty?(seat_layout[row][col])
          next_layout[row][col] = '#'
        elsif occupied_count > 4 && occupied?(seat_layout[row][col])
          next_layout[row][col] = 'L'
        end
      end
    end

    next_layout
  end

  def occupied_in_layout(seat_layout)
    count = 0
    (0..seat_layout.length - 1).each do |row|
      (0..seat_layout[0].length - 1).each do |col|
        count += 1 if occupied?(seat_layout[row][col])
      end
    end

    count
  end

  def main
    seats_layout = seats.map { |line| line.split('') }
    puts "#{occupied_in_layout(seats_layout)}"

    Kernel.loop do
      seats_layout = next_state(seats_layout)
      puts "#{occupied_in_layout(seats_layout)}"
    end
  end
end

Day11.new.main
