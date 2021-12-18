defmodule Aoc.Day01Test do
  use ExUnit.Case
  alias Aoc.Day01

  test "calculates fuel" do
    assert Day01.calculate_fuel(12) == 2
    assert Day01.calculate_fuel(14) == 2
    assert Day01.calculate_fuel(1_969) == 654
    assert Day01.calculate_fuel(100_756) == 33_583
  end

  test "calculates total fuel" do
    assert Day01.calculate_total_fuel(14) == 2
    assert Day01.calculate_total_fuel(1_969) == 966
    assert Day01.calculate_total_fuel(100_756) == 50_346
  end
end
