defmodule Advent.DayFive do
  @doc """
  --- Day 5: Hydrothermal Venture ---

  You come across a field of hydrothermal vents on the ocean floor! These vents
  constantly produce large, opaque clouds, so it would be best to avoid them if
  possible.

  They tend to form in lines; the submarine helpfully produces a list of nearby
  lines of vents (your puzzle input) for you to review. For example:

  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2

  Each line of vents is given as a line segment in the format x1,y1 -> x2,y2
  where x1,y1 are the coordinates of one end the line segment and x2,y2 are the
  coordinates of the other end. These line segments include the points at both
  ends. In other words:

      An entry like 1,1 -> 1,3 covers points 1,1, 1,2, and 1,3.
      An entry like 9,7 -> 7,7 covers points 9,7, 8,7, and 7,7.

  For now, only consider horizontal and vertical lines: lines where either x1 = x2 or y1 = y2.

  So, the horizontal and vertical lines from the above list would produce the following diagram:

  .......1..
  ..1....1..
  ..1....1..
  .......1..
  .112111211
  ..........
  ..........
  ..........
  ..........
  222111....

  In this diagram, the top left corner is 0,0 and the bottom right corner is
  9,9. Each position is shown as the number of lines which cover that point or
  . if no line covers that point. The top-left pair of 1s, for example, comes
  from 2,2 -> 2,1; the very bottom row is formed by the overlapping lines 0,9
  -> 5,9 and 0,9 -> 2,9.

  To avoid the most dangerous areas, you need to determine the number of points
  where at least two lines overlap. In the above example, this is anywhere in
  the diagram with a 2 or larger - a total of 5 points.

  Consider only horizontal and vertical lines. At how many points do at least two lines overlap?

  ## Examples

  iex> Advent.DayFive.part_one([
  ...>   [[0,9], [5,9]],
  ...>   [[8,0], [0,8]],
  ...>   [[9,4], [3,4]],
  ...>   [[2,2], [2,1]],
  ...>   [[7,0], [7,4]],
  ...>   [[6,4], [2,0]],
  ...>   [[0,9], [2,9]],
  ...>   [[3,4], [1,4]],
  ...>   [[0,0], [8,8]],
  ...>   [[5,5], [8,2]]
  ...> ])
  5
  """
  def part_one(vents) do
    vents
    |> Enum.reduce(%{}, fn 
      [[x, y1], [x, y2]], acc -> 
        y1..y2
        |> Enum.reduce(acc, fn y, acc -> Map.update(acc, [x, y], 1, & &1 + 1) end)
      [[x1, y], [x2, y]], acc -> 
        x1..x2
        |> Enum.reduce(acc, fn x, acc -> Map.update(acc, [x, y], 1, & &1 + 1) end)
      _, acc -> acc
    end)
    |> Enum.filter(&(elem(&1, 1) > 1))
    |> Enum.count()
  end

  @doc """
  --- Part Two ---

  Unfortunately, considering only horizontal and vertical lines doesn't give
  you the full picture; you need to also consider diagonal lines.

  Because of the limits of the hydrothermal vent mapping system, the lines in
  your list will only ever be horizontal, vertical, or a diagonal line at
  exactly 45 degrees. In other words:

      An entry like 1,1 -> 3,3 covers points 1,1, 2,2, and 3,3.
      An entry like 9,7 -> 7,9 covers points 9,7, 8,8, and 7,9.

  Considering all lines from the above example would now produce the following diagram:

  1.1....11.
  .111...2..
  ..2.1.111.
  ...1.2.2..
  .112313211
  ...1.2....
  ..1...1...
  .1.....1..
  1.......1.
  222111....

  You still need to determine the number of points where at least two lines
  overlap. In the above example, this is still anywhere in the diagram with a 2
  or larger - now a total of 12 points.

  Consider all of the lines. At how many points do at least two lines overlap?

  ## Examples

  iex> Advent.DayFive.part_two([
  ...>   [[0,9], [5,9]],
  ...>   [[8,0], [0,8]],
  ...>   [[9,4], [3,4]],
  ...>   [[2,2], [2,1]],
  ...>   [[7,0], [7,4]],
  ...>   [[6,4], [2,0]],
  ...>   [[0,9], [2,9]],
  ...>   [[3,4], [1,4]],
  ...>   [[0,0], [8,8]],
  ...>   [[5,5], [8,2]]
  ...> ])
  12
  """
  def part_two(vents) do
    vents
    |> Enum.reduce(%{}, fn 
      [[x, y1], [x, y2]], acc -> 
        y1..y2
        |> Enum.reduce(acc, fn y, acc -> Map.update(acc, [x, y], 1, & &1 + 1) end)
      [[x1, y], [x2, y]], acc -> 
        x1..x2
        |> Enum.reduce(acc, fn x, acc -> Map.update(acc, [x, y], 1, & &1 + 1) end)
      [[x1, y1], [x2, y2]], acc when abs(x1 - x2) === abs(y1 - y2) -> 
        coords_from_diagonals(x1, y1, x2, y2)
        |> Enum.reduce(acc, fn [x,y], acc -> Map.update(acc, [x, y], 1, & &1 + 1) end)
      _, acc -> acc
    end)
    |> Enum.filter(&(elem(&1, 1) > 1))
    |> Enum.count()
  end

  @doc """
  ## Examples
  
  iex> Advent.DayFive.coords_from_diagonals(5,5,8,2)
  [
    [5,5],
    [6,4],
    [7,3],
    [8,2]
  ]
  """
  def coords_from_diagonals(x1, y1, x2, y2) do
    [x1..x2, y1..y2]
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
