defmodule Advent.DayFiveTest do
  use ExUnit.Case, async: true
  doctest Advent.DayFive

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_five_input.txt")
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn line ->
        line
        |> String.split(" -> ", trim: true)
        |> Enum.map(fn coord ->
          coord
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
        end)
      end)

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayFive.part_one(input) == 5_373
  end

  test "part two", %{input: input} do
    assert Advent.DayFive.part_two(input) == 21_514
  end
end
