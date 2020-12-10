# 2020: Day10
# Part 1
# Sort an array of integers, find the counts of differences of 1 and 3 within
# the array. Take those differences and find a product.

require_relative './utils'
require 'set'

# Day10
class Day10
  include Utils

  def main
    jolts = read_file('day10.txt').map(&:to_i).sort
    # We are pre-pending a 0 to represent the outlet.
    jolts.unshift(0)
    # We will push the max value + 3 to the end to represent the device.
    jolts.push(jolts[-1] + 3)

    one_jolt_differences = 0
    three_jolt_differences = 0
    left = 0
    right = left + 1

    while right < jolts.length
      one_jolt_differences += 1 if jolts[right] - jolts[left] == 1
      three_jolt_differences += 1 if jolts[right] - jolts[left] == 3

      left += 1
      right += 1
    end

    puts one_jolt_differences * three_jolt_differences
  end
end

Day10.new.main
