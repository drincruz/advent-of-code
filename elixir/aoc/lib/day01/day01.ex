defmodule Aoc.Day01 do
  @moduledoc """
  Day 01.

  The Tyranny of the Rocket Equation.

  Part 1
    * Find the sum of the fuel requirements.
  Part 2
    * Find the sum of the fuel requirements, but consider that additional fuel
    requires more fuel.
  """
  @day01 Path.join(["lib/day01/data.txt"])

  @doc """
  Read the input file.
  """
  def read do
    File.stream!(@day01, [], :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end

  @doc """
  Function to calculate the mass.

  We will use this to map the entire data.
  """
  def calculate_fuel(mass) do
    mass
    |> Kernel./(3)
    |> floor()
    |> Kernel.-(2)
  end

  @doc """
  Considering additional fuel will need more fuel, calculate total fuel.

  This function recursively gets a list of fuel totals using calculate_fuel/1
  until the mass of required additional fuel is 0.
  """
  def calculate_total_fuel(mass), do: calculate_total_fuel(mass, [])
  def calculate_total_fuel(mass, total_fuel) when mass < 3, do: Enum.sum(total_fuel)

  def calculate_total_fuel(mass, total_fuel) do
    case calculate_fuel(mass) do
      fuel when fuel < 1 -> calculate_total_fuel(0, total_fuel)
      fuel -> calculate_total_fuel(fuel, [fuel | total_fuel])
    end
  end

  @doc """
  This will bind all of our functions together and calculate the fuel requirements.

   - Read the file
   - Calculate the fuel requirements per mass
   - Sum the updated data
  """
  def fuel_requirements do
    read()
    |> Stream.map(&calculate_fuel/1)
    |> Enum.sum()
  end

  @doc """
  This will bind all of our functions together and calculate the fuel requirements.

   - Read the file
   - Calculate the total fuel requirements per mass
   - Sum the updated data
  """
  def total_fuel_requirements do
    read()
    |> Stream.map(&calculate_total_fuel/1)
    |> Enum.sum()
  end
end
