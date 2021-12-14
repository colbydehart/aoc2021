defmodule Advent.DayNine do
  require Logger

  @doc """
  --- Day 9: Smoke Basin ---

  These caves seem to be lava tubes. Parts are even still volcanically active;
  small hydrothermal vents release smoke into the caves that slowly settles
  like rain.

  If you can model how the smoke flows through the caves, you might be able to
  avoid it and be that much safer. The submarine generates a heightmap of the
  floor of the nearby caves for you (your puzzle input).

  Smoke flows to the lowest point of the area it's in. For example, consider
  the following heightmap:

  2199943210
  3987894921
  9856789892
  8767896789
  9899965678

  Each number corresponds to the height of a particular location, where 9 is
  the highest and 0 is the lowest a location can be.

  Your first goal is to find the low points - the locations that are lower than
  any of its adjacent locations. Most locations have four adjacent locations
  (up, down, left, and right); locations on the edge or corner of the map have
  three or two adjacent locations, respectively. (Diagonal locations do not
  count as adjacent.)

  In the above example, there are four low points, all highlighted: two are in
  the first row (a 1 and a 0), one is in the third row (a 5), and one is in the
  bottom row (also a 5). All other locations on the heightmap have some lower
  adjacent location, and so are not low points.

  The risk level of a low point is 1 plus its height. In the above example, the
  risk levels of the low points are 2, 1, 6, and 6. The sum of the risk levels
  of all low points in the heightmap is therefore 15.

  Find all of the low points on your heightmap. What is the sum of the risk
  levels of all low points on your heightmap?

  ## Examples

  iex> Advent.DayNine.part_one([
  ...>   [2,1,9,9,9,4,3,2,1,0],
  ...>   [3,9,8,7,8,9,4,9,2,1],
  ...>   [9,8,5,6,7,8,9,8,9,2],
  ...>   [8,7,6,7,8,9,6,7,8,9],
  ...>   [9,8,9,9,9,6,5,6,7,8],
  ...> ])
  15
  """
  def part_one(map) do
    map
    |> low_points()
    |> Enum.map(fn [x, y] -> pos(map, x, y) + 1 end)
    |> Enum.sum()
  end

  @doc """
  --- Part Two ---

  Next, you need to find the largest basins so you know what areas are most
  important to avoid.

  A basin is all locations that eventually flow downward to a single low point.
  Therefore, every low point has a basin, although some basins are very small.
  Locations of height 9 do not count as being in any basin, and all other
  locations will always be part of exactly one basin.

  The size of a basin is the number of locations within the basin, including
  the low point. The example above has four basins.

  The top-left basin, size 3:

  2199943210
  3987894921
  9856789892
  8767896789
  9899965678

  The top-right basin, size 9:

  2199943210
  3987894921
  9856789892
  8767896789
  9899965678

  The middle basin, size 14:

  2199943210
  3987894921
  9856789892
  8767896789
  9899965678

  The bottom-right basin, size 9:

  2199943210
  3987894921
  9856789892
  8767896789
  9899965678

  Find the three largest basins and multiply their sizes together. In the above
  example, this is 9 * 14 * 9 = 1134.

  What do you get if you multiply together the sizes of the three largest basins?

  ## Examples

  iex> Advent.DayNine.part_two([
  ...>   [2,1,9,9,9,4,3,2,1,0],
  ...>   [3,9,8,7,8,9,4,9,2,1],
  ...>   [9,8,5,6,7,8,9,8,9,2],
  ...>   [8,7,6,7,8,9,6,7,8,9],
  ...>   [9,8,9,9,9,6,5,6,7,8],
  ...> ])
  1134
  """
  def part_two(map) do
    low_points(map)
    |> Enum.map(&basin_size(map, &1))
    |> Enum.sort()
    |> Enum.take(3)
    |> Enum.reduce(&Kernel.*/2)
  end

  def basin_size(map, [x, y]) do
    map
    |> neighbors(x, y)
    |> Enum.map(&climb(map, &1))
    |> Enum.sum()
  end

  def climb(map, [x, y]) do
    case pos(map, x, y) do
      9 ->
        0

      nil ->
        0

      _ ->
        neighbors(map, x, y)
        |> Enum.map(&climb(map, &1))
        |> Enum.sum()
        |> Kernel.+(1)
    end
  end

  # Util functions
  defp low_points(map) do
    for(x <- 0..width(map), y <- 0..(height(map) - 1), do: [x, y])
    |> Enum.filter(&lowest_point(map, &1))
  end

  defp lowest_point(map, [x, y]) do
    map
    |> neighbors(x, y)
    |> Enum.filter(&(&1 !== [x, y]))
    |> Enum.all?(fn [x_, y_] ->
      pos(map, x_, y_) > pos(map, x, y)
    end)
  end

  defp neighbors(map, x, y) do
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
    |> Enum.filter(fn [xd, yd] -> in_bounds?(map, x + xd, y + yd) end)
    |> Enum.map(fn [xd, yd] -> [x + xd, y + yd] end)
  end

  defp in_bounds?(map, x, y) do
    width(map) > x and x >= 0 and height(map) > y and y >= 0
  end

  defp pos(map, x, y) do
    if in_bounds?(map, x, y) do
      map
      |> Enum.at(y)
      |> Enum.at(x)
    else
      nil
    end
  end

  defp width(map), do: Enum.count(Enum.at(map, 0))
  defp height(map), do: Enum.count(map)
end
