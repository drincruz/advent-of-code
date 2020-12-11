# 2020: Day10
# Part 1
# Sort an array of integers, find the counts of differences of 1 and 3 within
# the array. Take those differences and find a product.
# Part 2
# Using the sorted array of integers, now find all combinations of the array
# that still support the rules of an integers being within +3.

require_relative './utils'
require 'set'

# Day10
class Day10
  include Utils

  def jolts
    jolts = read_file('day10.txt').map(&:to_i).sort
    # We are pre-pending a 0 to represent the outlet.
    jolts.unshift(0)
    # We will push the max value + 3 to the end to represent the device.
    jolts.push(jolts[-1] + 3)

    jolts
  end

  def main
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

  def fn
    @combinations = []
    (0..jolts.length).each { |n| backtrack(n, [0]) }
    puts @combinations
  end

  def backtrack(index, tmp_arr)
    @combinations.push(tmp_arr) if index == jolts.length

    (index..jolts.length - 1).each do |i|
      tmp_arr.push(tmp_arr[i])
      backtrack(index + 1, tmp_arr + [jolts[i]])
      tmp_arr.shift
    end
  end
end

Day10.new.fn
