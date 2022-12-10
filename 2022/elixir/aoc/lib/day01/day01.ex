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
  Return a Stream list of calories sums.

   - Read in values from data.txt
   - Sum the sub-lists
   - Sort sums of the list
  """
  def get_list_of_calorie_sums do
    read()
    |> Stream.chunk_by(fn val -> val != nil end)
    |> Stream.reject(fn val -> val == [nil] end)
    |> Stream.map(fn sublist -> Enum.sum(sublist) end)
  end

  @doc """
  Return the max sum from the calories sums list.

   - Get the list of calories sums
   - Find the max
  """
  def elf_max do
    get_list_of_calorie_sums()
    |> Enum.max()
  end

  @doc """
  We want to calculate the top 3 sums of a list of lists.

   - Get the list of calories sums
   - Sort the list
   - Take the 3 largest values
   - Sum those values
  """
  def elf_top_3_max do
    get_list_of_calorie_sums()
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end
end
