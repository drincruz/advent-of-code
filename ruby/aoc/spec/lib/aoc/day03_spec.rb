require 'aoc/day03'

RSpec.describe Day03::Solution do
  let!(:solution) { Day03::Solution.new }

  describe "#parse_data" do
    it 'parses input properly' do
      wire0 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
      wire1 = "U62,R66,U55,R34,D71,R55,D58,R83"
      expected = [
        %w{R75 D30 R83 U83 L12 D49 R71 U7 L72},
        %w{U62 R66 U55 R34 D71 R55 D58 R83}
      ]
      expect(solution.parse_data([wire0, wire1])).to eq expected
    end
  end

  describe '#next_point' do
    it 'calculates the next point properly' do
      origin = [0, 0]
      expect(solution.next_point(origin, "U3")).to eq([0, 3])
    end
  end

  describe '#process' do
    it 'finds the Manhattan Distance of the closest point 0' do
      wire0 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
      wire1 = "U62,R66,U55,R34,D71,R55,D58,R83"
      data = solution.parse_data([wire0, wire1])

      expect(solution.process(data)).to eq(159)
    end

    it 'finds the Manhattan Distance of the closest point 1' do
      wire0 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
      wire1 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      data = solution.parse_data([wire0, wire1])

      expect(solution.process(data)).to eq(135)
    end
  end
end
