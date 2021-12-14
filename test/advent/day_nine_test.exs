defmodule Advent.DayNineTest do
  use ExUnit.Case, async: true
  doctest Advent.DayNine

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_nine_input.txt")
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DayNine.part_one(input) == 475
  end

  @tag :skip
  test "part two", %{input: input} do
    # assert Advent.DayNine.part_two(input) == nil
  end
end
