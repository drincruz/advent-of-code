# 2020: Day08
# Part 1

require_relative './utils'
require 'set'

# Day08
class Day08
  include Utils

  def parse_line(line)
    # Example lines:
    # nop +612
    # acc -6
    # jmp +388
    op, num = line.split(' ')

    [op, num.to_i]
  end

  def process_operations
    operations = read_file('day08.txt').map { |line| parse_line(line) }
    accumulation = 0
    seen_operations = Set.new
    operation_index = 0

    Kernel.loop do
      return accumulation if seen_operations.include?(operation_index)

      op, num = operations[operation_index]
      seen_operations.add(operation_index)

      if op == 'acc'
        accumulation += num
        operation_index += 1
      elsif op == 'jmp'
        operation_index += num
      else
        operation_index += 1
      end
    end
  end
end

puts Day08.new.process_operations
