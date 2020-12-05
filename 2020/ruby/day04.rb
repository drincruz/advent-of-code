# Advent of Code 2020: Day 03

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def update_passport(data, key, val)
  data[key] = val

  data
end

def valid?(passport_record)
  required = %w[byr ecl eyr hcl hgt iyr pid]

  required.all? { |key| passport_record.keys.include?(key) }
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
      # count += 1 if valid?(passport)
      if valid?(passport)
        puts "GOOD #{passport.keys.sort}"
        count += 1
      else
        puts "INVALID #{passport.keys.sort}"
      end
      passport = {}
    end

    parsed_data = parse_line(line)
    parsed_data.each { |k, v| passport = update_passport(passport, k, v) }
  end

  count
end

puts read_passport
