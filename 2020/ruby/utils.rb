# Util module for helpers.
module Utils
  def read_file(input_file)
    file = File.open(input_file)

    file.readlines.map(&:chomp)
  end
end
