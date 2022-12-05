defmodule Aoc.Day01 do
  @moduledoc """
  Day 01.

  Calorie Counting.

  Part 1
    * Find the elf carrying the most calories.
    * We just want the max sum of those calories.
  """
  @day01 Path.join(["lib/day01/data.txt"])

  @doc """
  Read the input file.
  """
  def read do
    File.stream!(@day01, [], :line)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&clean_data/1)
  end

  @doc """
  Clean the data by new lines.

  An empty line in our data means it is a new Elf.
  """
  def clean_data(""), do: nil
  def clean_data(input) when is_binary(input) do
    String.to_integer(input)
  end

  @doc """
  This will bind all of our functions together and calculate the elf.

   - Read the file
  """
  def elf_max do
    read()
    |> Stream.chunk_by(fn val -> val != nil end)
    |> Stream.reject(fn val -> val == [nil] end)
    |> Stream.map(fn sublist -> Enum.sum(sublist) end)
    |> Enum.max()
  end
end
