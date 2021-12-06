defmodule Advent.DayOneTest do
  use ExUnit.Case, async: true
  doctest Advent.DayOne

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_one_input.txt")
      |> File.read!()
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayOne.part_one(input) == 1_681
  end

  test "part two", %{input: input} do
    assert Advent.DayOne.part_two(input) == 1_704
  end
end
