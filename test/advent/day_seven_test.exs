defmodule Advent.DaySevenTest do
  use ExUnit.Case, async: true
  doctest Advent.DaySeven

  setup_all do
    input =
      :code.priv_dir(:advent)
      |> Path.join("./day_seven_input.txt")
      |> File.read!()
      |> String.split(",", trim: true)
      |> Enum.map(&String.replace(&1, "\n", ""))
      |> Enum.map(&String.to_integer/1)

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DaySeven.part_one(input) == 344_535
  end

  @tag timeout: :infinity
  @tag :skip
  test "part two", %{input: input} do
    assert Advent.DaySeven.part_two(input) == 95_581_659
  end
end
