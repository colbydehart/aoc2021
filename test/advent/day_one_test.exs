defmodule Advent.DayOneTest do
  use ExUnit.Case, async: true
  doctest Advent.DayOne

  # :code.priv_dir(:advent)
  # |> Path.join("./day_one_input.txt")
  # |> File.read!()
  # |> String.split()
  # |> Enum.map(&Integer.parse/1)
  # |> Enum.map(&elem(&1, 0))
  # |> Advent.DayOne.part_one()
  # >> 1681

  # :code.priv_dir(:advent)
  # |> Path.join("./day_one_input.txt")
  # |> File.read!()
  # |> String.split()
  # |> Enum.map(&Integer.parse/1)
  # |> Enum.map(&elem(&1, 0))
  # |> Advent.DayOne.part_two()
  # >> 1704
end
