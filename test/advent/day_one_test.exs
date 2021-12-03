defmodule Advent.DayOneTest do
  use ExUnit.Case, async: true
  doctest Advent.DayOne

  # :code.priv_dir(:advent)
  # |> Path.join("./day_one_input.txt")
  # |> File.read!()
  # |> String.split()
  # |> Enum.map(&String.to_integer/1)
  # |> Advent.DayOne.part_one()
  # >> 1681

  # :code.priv_dir(:advent)
  # |> Path.join("./day_one_input.txt")
  # |> File.read!()
  # |> String.split()
  # |> Enum.map(&String.to_integer/1)
  # |> Advent.DayOne.part_two()
  # >> 1704
end
