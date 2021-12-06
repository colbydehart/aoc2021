defmodule Advent.DaySixTest do
  use ExUnit.Case, async: true
  doctest Advent.DaySix

  setup_all do
    input = 
      (
        :code.priv_dir(:advent)
        |> Path.join("./day_six_input.txt")
        |> File.read!()
        |> String.split(",", trim: true)
        |> Enum.map(&String.replace(&1, "\n", ""))
        |> Enum.map(&String.to_integer/1)
      )

    [input: input]
  end

  test "part one", %{input: input} do
    assert Advent.DaySix.part_one(input, 80) == 394_994
  end

  @tag timeout: :infinity
  test "part two", %{input: input} do
    assert Advent.DaySix.part_one(input, 256) == nil
  end
end
