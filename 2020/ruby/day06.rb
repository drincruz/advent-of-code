# 2020: Day06
# Part 1
# Given groups of answers of a survey, count the unique amount of questions
# per group.
# Part 2
# Instead of counting questions where anyone answered yes, we want to count
# all the questions which _everyone_ answered yes.

require_relative './utils'
require 'set'

# Day06
class Day06
  include Utils

  def line_char_set(line)
    Set.new(line.split(''))
  end

  def read_answers
    groups = read_file('day06.txt')
    groups.push('')
    answers = []
    counts = []

    groups.each do |line|
      if line.length.zero?
        counts.push(answers.inject(:&).length)
        answers = []
        # We don't want to deal with an empty string now, so we will `next`.
        next
      end

      answers.push(line_char_set(line))
    end

    puts counts.sum
  end
end

Day06.new.read_answers
