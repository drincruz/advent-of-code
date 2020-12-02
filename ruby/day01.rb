#!/bin/ruby
# Advent of Code: Day01

def numbers_array(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp).map(&:to_i).sort
end

# target = 7
# [1, 2, 3, 5, 8]
#           X
def two_sum(target)
  nums = numbers_array('day01.txt')

  left = 0
  right = nums.length - 1

  while left < right
    tmp_sum = nums[left] + nums[right]
    return [nums[left], nums[right]] if tmp_sum == target

    if tmp_sum < target
      left += 1
    else
      right -= 1
    end
  end

  [-1, -1]
end

puts two_sum(2020)
