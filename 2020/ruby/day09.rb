# 2020: Day09
# Part 1
# Find the first number _after_ the preamble (25) that does not
# have two numbers that sum up to it in the previous 25 number sliding window.

require_relative './utils'
require 'set'

# Day09
class Day09
  include Utils

  def two_sum?(target, nums)
    left = 0
    seen_nums = Set.new

    while left < nums.length
      inverse = target - nums[left]
      return true if seen_nums.include?(inverse)

      seen_nums.add(nums[left])
      left += 1
    end

    false
  end

  def main
    numbers = read_file('day09.txt').map(&:to_i)

    start_index = 25
    left = 0
    right = 24

    while start_index < numbers.length
      target = numbers[start_index]
      return target unless two_sum?(target, numbers[left..right])

      left += 1
      right += 1
      start_index += 1
    end

    -1
  end
end

puts Day09.new.main
