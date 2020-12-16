# 2020: Day12
# Part 1
# Given an array of instructions, we want to navigate a ship along an X,Y plane.
# Once we have the final destination, we want to calculate the Manhattan
# Distance.
#
# Part 2
# Refactor Part 1, because now we have new instructions.
# N, S, E, W will move a waypoint.
# L, R will rotate a waypoint
# F will move the ship n-times towards the waypoint.
require_relative './utils'

# Day12
class Day12
  include Utils

  def data
    read_file('day12.txt')
  end

  def parse_line(line)
    # Line format: #{action}#{value}
    # Example line format: R90
    [line[0], line[1..-1].to_i]
  end

  def north_south(current, value)
    [current[0], current[1] + value]
  end

  def east_west(current, value)
    [current[0] + value, current[1]]
  end

  def directions
    %i[north east south west]
  end

  def left(current, value)
    # Rotate 90 degrees
    # (x, y) -> (y * -1, x)
    # Example:
    # - (10, 4)
    # - (-4, 10)
    # - (-10, -4)
    # - (4, -10)
    (0..(value / 90) - 1).inject(current) do |coordinate, _n|
      [coordinate[1] * -1, coordinate[0]]
    end
  end

  def right(current, value)
    # Rotate works similarly to left/2 except we'll take the negated value of y.
    (0..(value / 90) - 1).inject(current) do |coordinate, _n|
      [coordinate[1], coordinate[0] * -1]
    end
  end

  def forward(ship, waypoint, value)
    waypoint_x = waypoint[0] * value
    waypoint_y = waypoint[1] * value

    [ship[0] + waypoint_x, ship[1] + waypoint_y]
  end

  def main
    instructions = data.map { |line| parse_line(line) }
    current_direction = :east
    current_ship = [0, 0]
    current_waypoint = [10, 1]

    instructions.each do |action, value|
      if action == 'F'
        current_ship = forward(current_ship, current_waypoint, value)
      elsif action == 'N'
        current_waypoint = north_south(current_waypoint, value)
      elsif action == 'S'
        current_waypoint = north_south(current_waypoint, -1 * value)
      elsif action == 'E'
        current_waypoint = east_west(current_waypoint, value)
      elsif action == 'W'
        current_waypoint = east_west(current_waypoint, -1 * value)
      elsif action == 'L'
        current_waypoint = left(current_waypoint, value)
      elsif action == 'R'
        current_waypoint = right(current_waypoint, value)
      end
    end

    puts "#{current_ship} #{current_waypoint}"
    puts current_ship[0].abs + current_ship[1].abs
  end
end

Day12.new.main
