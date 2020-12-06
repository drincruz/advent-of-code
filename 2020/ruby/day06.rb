# 2020: Day06
# Part 1
# Given groups of answers of a survey, count the unique amount of questions
# per group.

require_relative './utils'
require 'set'

# Day06
class Day06
  include Utils

  def line_char_set(line, set_chars)
    set_chars.merge(Set.new(line.split('')))
  end

  def read_answers
    groups = read_file('day06.txt')
    groups.push('')
    answers = Set.new
    counts = []

    groups.each do |line|
      if line.length.zero?
        counts.push(answers.length)
        answers = Set.new
      end

      answers = line_char_set(line, answers)
    end

    puts counts.sum
  end
end

Day06.new.read_answers
