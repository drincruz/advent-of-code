# 2020: Day13
# Part 1
# Given the _earliest_ time (integer) I can leave, find the closest
# time to leave. In other words, what is the least factor of a number
# that is greater than my given integer.
require_relative './utils'

# Day13
class Day13
  include Utils

  def data
    read_file('day13.txt')
  end

  def exponential(num, minimum)
    i = 0
    while num**i < minimum
      i += 1
    end

    num**(i - 1)
  end

  def double_num(num, minimum)
    while num < minimum
      num *= 2
    end

    num / 2
  end

  def add_num(cur_sum, num, minimum)
    while cur_sum < minimum
      cur_sum += num
    end

    cur_sum
  end

  def closest_multiple(num, minimum)
    tmp = exponential(num, minimum)
    return tmp if tmp == minimum

    tmp = double_num(tmp, minimum)
    return tmp if tmp == minimum

    add_num(tmp, num, minimum)
  end

  def main
    earliest_time = data[0].to_i
    buses = data[1].split(',').reject { |x| x == 'x' }.map(&:to_i)
    time, id = buses.map { |id| [closest_multiple(id, earliest_time), id] }.min
    puts "#{earliest_time} #{time}"
    puts (time - earliest_time) * id
  end
end

Day13.new.main
