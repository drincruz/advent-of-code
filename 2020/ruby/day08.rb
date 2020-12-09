# 2020: Day08
# Part 1
# Find the loop in the operations and return the accumulation value.
# Part 2
# Refactor Part 1 to find the incorrect nop or jmp so that the sequence
# completes successfully. Return the accumulation value.

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

  def process_operations(operations)
    seen_operations = Set.new
    operation_index = 0
    accumulation = 0

    while operation_index < operations.length
      # if we are looping
      return nil if seen_operations.include?(operation_index)

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

    accumulation
  end

  def main
    operations = read_file('day08.txt').map { |line| parse_line(line) }
    i = 0

    while i < operations.length
      op, num = operations[i]

      if op == 'jmp'
        operations[i] = ['nop', num]
      elsif op == 'nop'
        operations[i] = ['jmp', num]
      else
        i += 1
        next
      end

      accumulation = process_operations(operations)

      if accumulation.nil?
        if op == 'jmp'
          operations[i] = ['jmp', num]
        elsif op == 'nop'
          operations[i] = ['nop', num]
        end

        i += 1
        next
      end

      return accumulation
    end
  end
end

puts Day08.new.main
