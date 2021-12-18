module Day03
  class Solution
    def read
      File.read("data/day03.txt").split("\n")
    end

    def parse_data(input)
      input.map{ |data| data.split(",") }
    end

    def next_point(current, operation)
      direction = operation[0]
      units = operation[1..-1].to_i

      case direction
      when 'D'
        [current[0], current[1] - units]
      when 'L'
        [current[0] - units, current[1]]
      when 'R'
        [current[0] + units, current[1]]
      when 'U'
        [current[0], current[1] + units]
      end
    end

    def fill_state(state, point0, point1)
      if point0[0] != point1[0]
        if point0[0] < point1[0]
          left = point0[0]
          right = point1[0]
        else
          left = point1[0]
          right = point0[0]
        end

        (left..right).each { |n|
          new_point = [n, point0[1]]
          state[new_point] = state.fetch(new_point, 0) + 1 ||  1
        }
      else
        if point0[1] < point1[1]
          left = point0[1]
          right = point1[1]
        else
          left = point1[1]
          right = point0[1]
        end

        (left..right).each { |n|
          new_point = [point0[0], n]
          state[new_point] = state.fetch(new_point, 0) + 1 ||  1
        }
      end

      state
    end

    def get_crossed_paths(wire_points)
      wire_points.select{ |point, count| count > 1 }
    end

    def manhattan_distance(point)
      point[0].abs + point[1].abs
    end

    # Honestly, this feels like there should've been a better approach.
    # But, I'm still new to Ruby, so I'm okay with this.
    def process(data)
      wire0_points = {}

      current_location = [0, 0]
      data.first.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire0_points, current_location, next_location)
        current_location = next_location
      }

      wire1_points = {}
      current_location = [0, 0]
      data.last.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire1_points, current_location, next_location)
        current_location = next_location
      }

      wire_crossed_points = wire0_points.keep_if { |k, v| wire1_points.key? k }

      wire_crossed_points.select {
        |point, count| point != [0, 0]
      }.map { |point, count| manhattan_distance(point) }.sort.first
    end

    def run
      process(parse_data(read))
    end
  end
end
