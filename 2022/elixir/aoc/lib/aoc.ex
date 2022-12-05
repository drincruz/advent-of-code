defmodule Aoc do
  @moduledoc """
  Documentation for `Aoc`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc.hello()
      :world

  """
  @spec hello() :: atom()
  def hello do
    :world
  end

  @spec hello(name: String.t()) :: String.t()
  def hello(name) do
    "Hello there, #{name}"
  end
end
