# Advent of Code 2020: Day 03

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

def valid_data?(passport_record)
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not.
  byr = passport_record.fetch("byr", 0).to_i
  return false if 1920 > byr || byr > 2002

  iyr = passport_record.fetch("iyr", 0).to_i
  return false if 2010 > iyr || iyr > 2020

  eyr = passport_record.fetch("eyr", 0).to_i
  return false if 2020 > eyr || eyr > 2030

  hgt = passport_record.fetch("hgt", false)
  return false unless hgt.end_with?('cm') || hgt.end_with?('in')

  if hgt.end_with?('cm')
    cm = hgt.sub!('cm', '').to_i
    return false if 150 > cm || cm > 193
  else
    inches = hgt.sub!('inches', '').to_i
    return false if 59 > inches || inches > 76
  end

  hcl = passport_record.fetch("hcl", false)
  return false unless hcl.start_with?('#')

  hcl.sub!('#', '')
  return false unless hcl.length == 6

  valid_chars = {}
  (0..9).each { |n| valid_chars[n.to_s] = 1 }
  ('a'..'f').each { |ch| valid_chars[ch] = 1 }
  return false unless hcl.split('').all? { |ch| valid_chars.fetch(ch, false) }

  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  ecl = passport_record.fetch("ecl", false)
  return false unless %w[amb blu brn gry grn hzl oth].include?(ecl)

  pid = passport_record.fetch("pid", false)
  return false unless pid.length == 9

  nums = (0..9).to_a.map { |n| n.to_s }
  pid.split('').all? { |n| nums.include?(n) }
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
