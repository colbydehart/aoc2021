defmodule Advent.DayThreeTest do
  use ExUnit.Case, async: true
  doctest Advent.DayThree

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_three_input.txt")
      |> File.read!()
      |> String.split("\n")
      |> Enum.filter(&(&1 !== ""))

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayThree.part_one(input) == 3_923_414
  end

  test "part two", %{input: input} do
    assert Advent.DayThree.part_two(input) == 5_852_595
  end
end
