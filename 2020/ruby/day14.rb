# 2020: Day14
# Part 1
# Given specific bitmasks and integers, get the sum of resultant integers
# that would be stored in memory.
# bitmask notes: a 0 or 1 overwrites the corresponding bit in the value,
# while an X leaves the bit in the value unchanged.
require_relative './utils'

# Day14
class Day14
  include Utils

  def instructions
    read_file('day14.txt')
  end

  def parse_mask(mask)
    mask
  end

  def parse_mem(location, num)
    match = /mem\[(?<loc>\d+)\]/.match(location)

    [match[:loc].to_i, num]
  end

  def mask_int(mask, num)
    binary_num = num.to_s(2).rjust(36, '0')

    i = 0
    while i < binary_num.length
      if mask[i] == '0' || mask[i] == '1'
        binary_num[i] = mask[i]
      end

      i += 1
    end

    binary_num
  end

  def main
    mask = nil
    memory = {}

    instructions.each do |line|
      key, val = line.split('=').map(&:strip)
      if line.start_with?('mask')
        mask = parse_mask(val)
      else
        address, num = parse_mem(key, val.to_i)
        memory[address] = mask_int(mask, num).to_i(2)
      end
    end

    puts "#{memory.values.sum}"
  end
end

Day14.new.main
