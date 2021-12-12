defmodule Advent.DayEightTest do
  use ExUnit.Case, async: true
  doctest Advent.DayEight

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_eight_input.txt")
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("|", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
      end)

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayEight.part_one(input) == 245
  end

  test "part two", %{input: input} do
    assert Advent.DayEight.part_two(input) == 983_026
  end
end
