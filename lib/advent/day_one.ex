defmodule Advent.DayOne do
  @doc """
  Collect stars by solving puzzles. Two puzzles will be made available on each
  day in the Advent calendar; the second puzzle is unlocked when you complete
  the first. Each puzzle grants one star. Good luck!

  As the submarine drops below the surface of the ocean, it automatically
  performs a sonar sweep of the nearby sea floor. On a small screen, the sonar
  sweep report (your puzzle input) appears: each line is a measurement of the
  sea floor depth as the sweep looks further and further away from the
  submarine.

  For example, suppose you had the following report:

  199 200 208 210 200 207 240 269 260 263

  This report indicates that, scanning outward from the submarine, the sonar
  sweep found depths of 199, 200, 208, 210, and so on.

  The first order of business is to figure out how quickly the depth increases,
  just so you know what you're dealing with - you never know if the keys will
  get carried into deeper water by an ocean current or a fish or something.

  To do this, count the number of times a depth measurement increases from the
  previous measurement. (There is no measurement before the first measurement.)
  In the example above, the changes are as follows:

  199 (N/A - no previous measurement) 200 (increased) 208 (increased) 210
  (increased) 200 (decreased) 207 (increased) 240 (increased) 269 (increased) 260
  (decreased) 263 (increased)

  In this example, there are 7 measurements that are larger than the previous
  measurement.

  How many measurements are larger than the previous measurement?


  ## Examples

  iex> Advent.DayOne.part_one([1,2,3,4,5])
  4

  iex> Advent.DayOne.part_one([5,4,3,2,1])
  0

  iex> Advent.DayOne.part_one([1,2,3,2,1])
  2
  """
  @spec part_one(input :: list(integer)) :: non_neg_integer
  def part_one(input) do
    input
    |> Enum.reduce(&count_increases/2)
    |> Map.get(:total, 0)
  end

  def count_increases(second, first) when is_integer(first) and is_integer(second),
    do: %{total: if(second > first, do: 1, else: 0), last: second}

  def count_increases(next, %{total: total, last: last}),
    do: %{total: if(next > last, do: total + 1, else: total), last: next}

  @doc """
  Start by comparing the first and second
  three-measurement windows. The measurements in the first
  window are marked A (199, 200, 208); their sum is 199 +
  200 + 208 = 607. The second window is marked B (200,
  208, 210); its sum is 618. The sum of measurements in
  the second window is larger than the sum of the first,
  so this first comparison increased.

  Your goal now is to count the number of times the sum of
  measurements in this sliding window increases from the
  previous sum. So, compare A with B, then compare B with
  C, then C with D, and so on. Stop when there aren't
  enough measurements left to create a new
  three-measurement sum.

  In the above example, the sum of each three-measurement
  window is as follows:

  A: 607 (N/A - no previous sum) B: 618 (increased) C: 618
  (no change) D: 617 (decreased) E: 647 (increased) F: 716
  (increased) G: 769 (increased) H: 792 (increased)

  In this example, there are 5 sums that are larger than
  the previous sum.

  Consider sums of a three-measurement sliding window. How
  many sums are larger than the previous sum?

  ## Examples
  iex> Advent.DayOne.part_two([607,618,618,617,647,716,769,792])
  5
  """
  def part_two(input), do: part_two(input, total: 0)

  def part_two([_, _, _], total: total), do: total

  def part_two([a, b, c, d] = input, total: total) when a + b + c < b + c + d,
    do: part_two(tl(input), total: total + 1)

  def part_two([a, b, c, d | _] = input, total: total) when a + b + c < b + c + d,
    do: part_two(tl(input), total: total + 1)

  def part_two(input, total: total),
    do: part_two(tl(input), total: total)
end
