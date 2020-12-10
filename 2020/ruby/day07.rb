# 2020: Day07
# Part 1
# Given rules of bags and colours, we'll want to count the number of bags
# that can contain 'shiny gold'.
#
# Part 2
# Refactor Part 1 to now calculate the count of bags in total.
# Note: not just the count of colours.
# shiny gold bags contain 4 posh coral bags, 2 clear violet bags.

require_relative './utils'
require 'set'

# Day07
class Day07
  include Utils

  def parse_line(line, bags)
    # Example line:
    # bright lavender bags contain 5 shiny teal bags.
    # (\w+\ \w+)\ bags\ contain\ (\d\ \w+\ \w+)\ bags?\.
    variant, contains = line.split('bags contain').map(&:strip)
    bags[variant] = parse_contains(contains)

    bags
  end

  def parse_contains(contains)
    # Example contains: 5 shiny teal bags.
    variants = {}

    contains.split(', ').each do |bag|
      matches = /(?<num>\d)\ (?<variant>\w+\ \w+) bags?/.match(bag)

      variants[matches[:variant]] = matches[:num].to_i unless matches.nil?
    end

    variants
  end

  def build_data
    rules = read_file('day07.txt')
    data = {}

    rules.each do |rule|
      data = parse_line(rule, data)
    end

    data
  end

  def calculate_bag_colours
    queue = ['shiny gold']
    rules_hash = build_data
    bags_to_count = Set.new

    while queue.length.positive?
      target = queue.shift
      rules_hash.each do |variant, bags|
        if bags.fetch(target, nil)
          bags_to_count.add(variant)
          queue.push(variant)
        end
      end
    end

    puts bags_to_count.length
  end

  def calculate_shiny_gold_bag_total
    rules_hash = build_data

    bag_counts = fn('shiny gold', rules_hash, ['1 shiny gold'])
    puts "#{bag_counts}"
  end

  def fn(variant, rules, stack=[])
    bags = rules.fetch(variant, {})

    return 1 if bags.empty?

    bags.each do |bag, val|
      stack.push("#{val} * #{bag}")
      fn(bag, rules, stack)
    end

    stack
  end
end

Day07.new.calculate_shiny_gold_bag_total
