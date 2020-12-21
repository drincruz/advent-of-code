# 2020: Day15
# Part 1
# Given seed data of integers, we want to loop through our sequence and find the
# 2020th integer in the sequence.
# Rules
#  - We will evaluate the last number "spoken" (previous number) and if the
# number was not spoken already, we'll say "0".
#  - If the number was spoken already, we'll get the difference between the last
# time it was spoken and the previous.
# - If the number was spoken twice in a row, say "1".

# Day15
class Day15
  def eval_last(arr)
    last_num = arr[-1]
    last_index = previous_index(arr, last_num)

    if last_num == arr[-2]
      1
    elsif last_index.positive? || last_index.zero?
      arr.length - (last_index + 1)
    else
      0
    end
  end

  def previous_index(arr, num)
    index = arr.length - 2

    while index >= 0
      return index if arr[index] == num

      index -= 1
    end

    -1
  end

  def main
    sequence = [2, 0, 6, 12, 1, 3]
    puts "#{sequence}"

    while sequence.length < 2020
      new_num = eval_last(sequence)
      sequence.push(new_num)
    end

    puts "#{sequence}\n#{sequence[-1]}"
  end
end

Day15.new.main
