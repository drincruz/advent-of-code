# Advent of Code 2020: Day 02

def read_file(input_file)
  file = File.open(input_file)

  file.readlines.map(&:chomp)
end

def parse_line(line)
  # Example line looks like the following:
  # 5-7 k: blkqhtxfgktdkxzkksk
  requirements, password = line.split(':')
  range, char = requirements.split(' ')
  min_ch, max_ch = range.split('-')

  {
    min: min_ch.to_i,
    max: max_ch.to_i,
    char: char,
    password: password.strip
  }
end

def password_valid?(password_data)
  password = password_data.fetch(:password)

  count = 0
  password.split('').each do |ch|
    count += 1 if ch == password_data.fetch(:char)
    return false if count > password_data.fetch(:max)
  end

  count >= password_data.fetch(:min)
end

def valid_passwords
  input = read_file('day02.txt')

  input
    .map { |line| parse_line(line) }
    .select { |data| password_valid?(data) }
    .length
end

puts valid_passwords
