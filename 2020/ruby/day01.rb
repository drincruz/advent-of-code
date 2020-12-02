#!/bin/ruby
# Advent of Code: Day01

def numbers_array(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp).map(&:to_i).sort
end

# target = 7
# [1, 2, 3, 5, 8]
#           X
def two_sum(target, nums)
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

def three_sum(target)
  nums = numbers_array('day01.txt')
  nums.each_with_index do |num, index|
    tmp_target = target - num
    x, y = two_sum(tmp_target, nums[index + 1..-1])
    return [num, x, y] if x.positive? && y.positive?
  end

  -1
end

puts three_sum(2020)
