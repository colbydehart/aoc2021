defmodule Advent.DayFourTest do
  use ExUnit.Case, async: true
  doctest Advent.DayFour

  [numbers | boards] =
    :code.priv_dir(:advent)
    |> Path.join("./day_four_input.txt")
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(&(&1 !== ""))

  numbers = numbers |> String.split(",") |> Enum.map(&String.to_integer/1)

  boards =
    boards
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
    |> Enum.chunk_every(5)

  Advent.DayFour.bingo(numbers, boards)

  # :code.priv_dir(:advent)
  # |> Path.join("./day_four_input.txt")
  # |> File.read!()
  # |> String.split("\n")
  # |> Enum.filter(&(&1 !== ""))
  # |> Advent.DayFour.part_two()
end
