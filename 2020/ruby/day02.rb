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
    pos0: min_ch.to_i,
    pos1: max_ch.to_i,
    char: char,
    password: password.strip
  }
end

def password_valid?(password_data)
  password = password_data.fetch(:password)
  pos0 = password_data.fetch(:pos0)
  pos1 = password_data.fetch(:pos1)
  chars = [password[pos0 - 1], password[pos1 - 1]]

  return false if chars.all? { |ch| ch == password_data.fetch(:char) }
  return true if chars.any? { |ch| ch == password_data.fetch(:char) }
  false
end

def valid_passwords
  input = read_file('day02.txt')

  input
    .map { |line| parse_line(line) }
    .select { |data| password_valid?(data) }
    .length
end

puts valid_passwords
