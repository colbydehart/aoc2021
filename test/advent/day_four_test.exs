defmodule Advent.DayFourTest do
  use ExUnit.Case, async: true
  doctest Advent.DayFour

  setup_all do
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

    [numbers: numbers, boards: boards]
  end

  test "part one", %{numbers: numbers, boards: boards} do
    assert Advent.DayFour.bingo(numbers, boards) == 25_023
  end

  test "part two", %{numbers: numbers, boards: boards} do
    assert Advent.DayFour.reverse_bingo(numbers, boards) == 2_634
  end
end
