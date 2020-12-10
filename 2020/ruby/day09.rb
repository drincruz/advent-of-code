# 2020: Day09
# Part 1
# Find the first number _after_ the preamble (25) that does not
# have two numbers that sum up to it in the previous 25 number sliding window.
# Part 2
# Now find a sub-array that sums up to 507622668.
# Within this sub-array, return [min, max].

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

  def found_target?(target, nums)
    nums.sum == target
  end

  def main
    numbers = read_file('day09.txt').map(&:to_i)
    left = 0
    target = 507_622_668

    while left < numbers.length
      right = left + 1
      while right < numbers.length
        tmp_arr = numbers[left..right]
        return tmp_arr.minmax.sum if found_target?(target, tmp_arr)

        break if tmp_arr.sum > target

        right += 1
      end
      left += 1
    end

    -1
  end
end

puts Day09.new.main
