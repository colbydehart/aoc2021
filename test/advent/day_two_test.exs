defmodule Advent.DayTwoTest do
  use ExUnit.Case, async: true
  doctest Advent.DayTwo

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_two_input.txt")
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(&(&1 !== ""))

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayTwo.part_one(input) == 1_488_669
  end

  test "part two", %{input: input} do
    assert Advent.DayTwo.part_two(input) == 1_176_514_794
  end
end
