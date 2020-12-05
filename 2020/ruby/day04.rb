# Advent of Code 2020: Day 04
require 'set'

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def update_passport(data, key, val)
  data[key] = val

  data
end

def valid_keys?(passport_record)
  # byr (Birth Year)
  # cid (Country ID) *optional*
  # ecl (Eye Color)
  # eyr (Expiration Year)
  # hcl (Hair Color)
  # hgt (Height)
  # iyr (Issue Year)
  # pid (Passport ID)
  required = %w[byr ecl eyr hcl hgt iyr pid]

  required.all? { |key| passport_record.keys.include?(key) }
end

def birth_year?(byr)
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  byr.between?(1920, 2002)
end

def issue_year?(iyr)
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  iyr.between?(2010, 2020)
end

def expiration_year?(eyr)
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  eyr.between?(2020, 2030)
end

def height?(hgt)
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  return false unless hgt.end_with?('cm') || hgt.end_with?('in')

  return centimeters_height?(hgt) if hgt.end_with?('cm')
  return inches_height?(hgt) if hgt.end_with?('in')
end

def centimeters_height?(hgt)
  cm = hgt[0..-3].to_i
  cm.between?(150, 193)
end

def inches_height?(hgt)
  inches = hgt[0..-3].to_i
  inches.between?(59, 76)
end

def hair_colour?(hcl)
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  return false unless hcl.start_with?('#')

  hcl_chars = hcl[1..-1]
  return false unless hcl_chars.length == 6

  chars = ('a'..'f').to_a
  numbers = (0..9).to_a.map(&:to_s)
  valid_chars = Set.new(chars + numbers)

  hcl_chars.split('').all? { |ch| valid_chars.include?(ch) }
end

def eye_colour?(ecl)
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  %w[amb blu brn gry grn hzl oth].include?(ecl)
end

def passport_id?(pid)
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  return false unless pid.length == 9

  numbers = (0..9).to_a.map(&:to_s)
  pid.split('').all? { |n| numbers.include?(n) }
end

def valid_data?(passport_record)
  return false unless birth_year?(passport_record.fetch('byr').to_i)
  return false unless issue_year?(passport_record.fetch('iyr').to_i)
  return false unless expiration_year?(passport_record.fetch('eyr').to_i)
  return false unless height?(passport_record.fetch('hgt'))
  return false unless hair_colour?(passport_record.fetch('hcl'))
  return false unless eye_colour?(passport_record.fetch('ecl'))
  return false unless passport_id?(passport_record.fetch('pid'))

  true
end

def parse_line(line)
  line.split(' ').map { |data| data.split(':') }
end

def read_passport
  data = read_file('day04.txt')

  passport = {}
  count = 0
  data.each do |line|
    if line.length.zero?
      count += 1 if valid_keys?(passport) && valid_data?(passport)
      passport = {}
    end

    parsed_data = parse_line(line)
    parsed_data.each { |k, v| passport = update_passport(passport, k, v) }
  end

  # We need to check the last passport record.
  valid_keys?(passport) && valid_data?(passport) ? count + 1 : count
end

puts read_passport
