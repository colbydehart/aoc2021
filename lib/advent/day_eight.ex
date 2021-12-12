defmodule Advent.DayEight do
  @doc """
  --- Day 8: Seven Segment Search ---

  You barely reach the safety of the cave when the whale smashes into the cave
  mouth, collapsing it. Sensors indicate another exit to this cave at a much
  greater depth, so you have no choice but to press on.

  As your submarine slowly makes its way through the cave system, you notice
  that the four-digit seven-segment displays in your submarine are
  malfunctioning; they must have been damaged during the escape. You'll be in a
  lot of trouble without them, so you'd better figure out what's wrong.

  Each digit of a seven-segment display is rendered by turning on or off any of
  seven segments named a through g:

    0:      1:      2:      3:      4:
   aaaa    ....    aaaa    aaaa    ....
  b    c  .    c  .    c  .    c  b    c
  b    c  .    c  .    c  .    c  b    c
   ....    ....    dddd    dddd    dddd
  e    f  .    f  e    .  .    f  .    f
  e    f  .    f  e    .  .    f  .    f
   gggg    ....    gggg    gggg    ....

    5:      6:      7:      8:      9:
   aaaa    aaaa    aaaa    aaaa    aaaa
  b    .  b    .  .    c  b    c  b    c
  b    .  b    .  .    c  b    c  b    c
   dddd    dddd    ....    dddd    dddd
  .    f  e    f  .    f  e    f  .    f
  .    f  e    f  .    f  e    f  .    f
   gggg    gggg    ....    gggg    gggg

  So, to render a 1, only segments c and f would be turned on; the rest would
  be off. To render a 7, only segments a, c, and f would be turned on.

  The problem is that the signals which control the segments have been mixed up
  on each display. The submarine is still trying to display numbers by
  producing output on signal wires a through g, but those wires are connected
  to segments randomly. Worse, the wire/segment connections are mixed up
  separately for each four-digit display! (All of the digits within a display
  use the same connections, though.)

  So, you might know that only signal wires b and g are turned on, but that
  doesn't mean segments b and g are turned on: the only digit that uses two
  segments is 1, so it must mean segments c and f are meant to be on. With just
  that information, you still can't tell which wire (b/g) goes to which segment
  (c/f). For that, you'll need to collect more information.

  For each display, you watch the changing signals for a while, make a note of
  all ten unique signal patterns you see, and then write down a single four
  digit output value (your puzzle input). Using the signal patterns, you should
  be able to work out which pattern corresponds to which digit.

  For example, here is what you might see in a single entry in your notes:

  acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
  cdfeb fcadb cdfeb cdbaf

  (The entry is wrapped here to two lines so it fits; in your notes, it will all be on a single line.)

  Each entry consists of ten unique signal patterns, a | delimiter, and finally
  the four digit output value. Within an entry, the same wire/segment
  connections are used (but you don't know what the connections actually are).
  The unique signal patterns correspond to the ten different ways the submarine
  tries to render a digit using the current wire/segment connections. Because 7
  is the only digit that uses three segments, dab in the above example means
  that to render a 7, signal lines d, a, and b are on. Because 4 is the only
  digit that uses four segments, eafb means that to render a 4, signal lines e,
  a, f, and b are on.

  Using this information, you should be able to work out which combination of
  signal wires corresponds to each of the ten digits. Then, you can decode the
  four digit output value. Unfortunately, in the above example, all of the
  digits in the output value (cdfeb fcadb cdfeb cdbaf) use five segments and
  are more difficult to deduce.

  For now, focus on the easy digits. Consider this larger example:

  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
  fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
  fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
  cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
  efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
  gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
  gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
  cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
  ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
  gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
  fgae cfgab fg bagce

  Because the digits 1, 4, 7, and 8 each use a unique number of segments, you
  should be able to tell which combinations of signals correspond to those
  digits. Counting only digits in the output values (the part after | on each
  line), in the above example, there are 26 instances of digits that use a
  unique number of segments (highlighted above).

  In the output values, how many times do digits 1, 4, 7, or 8 appear?

  ## Examples

  iex> Advent.DayEight.part_one([
  ...>   [
  ...>     ~w(be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb),
  ...>     ~w(fdgacbe cefdb cefbgd gcbe)
  ...>   ],
  ...>   [~w(edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec), ~w(fcgedb cgb dgebacf gc)],
  ...>   [~w(fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef), ~w(cg cg fdcagb cbg)],
  ...>   [
  ...>     ~w(fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega),
  ...>     ~w(efabcd cedba gadfec cb)
  ...>   ],
  ...>   [
  ...>     ~w(aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga),
  ...>     ~w(gecf egdcabf bgf bfgea)
  ...>   ],
  ...>   [
  ...>     ~w(fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf),
  ...>     ~w(gebdcfa ecba ca fadegcb)
  ...>   ],
  ...>   [
  ...>     ~w(dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf),
  ...>     ~w(cefg dcbef fcge gbcadfe)
  ...>   ],
  ...>   [~w(bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd), ~w(ed bcgafe cdgba cbgef)],
  ...>   [~w(egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg), ~w(gbdfcae bgc cg cgb)],
  ...>   [~w(gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc), ~w(fgae cfgab fg bagce)]
  ...> ])
  26
  """
  def part_one(input) do
    input
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.map(fn output ->
      output
      |> Enum.map(fn letters ->
        cond do
          String.length(letters) == 7 -> 1
          String.length(letters) == 3 -> 1
          String.length(letters) == 4 -> 1
          String.length(letters) == 2 -> 1
          true -> 0
        end
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  @doc """
  --- Part Two ---

  Through a little deduction, you should now be able to determine the remaining
  digits. Consider again the first example above:

  acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
  cdfeb fcadb cdfeb cdbaf

  After some careful analysis, the mapping between signal wires and segments
  only make sense in the following configuration:

   dddd
  e    a
  e    a
   ffff
  g    b
  g    b
   cccc

  So, the unique signal patterns would correspond to the following digits:

      eafb: 4
      ab: 1
      dab: 7
      acedgfb: 8

      gcdfa: 2
      fbcad: 3
      cdfbe: 5

      cefabd: 9
      cdfgeb: 6
      cagedb: 0

  Then, the four digits of the output value can be decoded:

      cdfeb: 5
      fcadb: 3
      cdfeb: 5
      cdbaf: 3

  Therefore, the output value for this entry is 5353.

  Following this same process for each entry in the second, larger example
  above, the output value of each entry can be determined:

      fdgacbe cefdb cefbgd gcbe: 8394
      fcgedb cgb dgebacf gc: 9781
      cg cg fdcagb cbg: 1197
      efabcd cedba gadfec cb: 9361
      gecf egdcabf bgf bfgea: 4873
      gebdcfa ecba ca fadegcb: 8418
      cefg dcbef fcge gbcadfe: 4548
      ed bcgafe cdgba cbgef: 1625
      gbdfcae bgc cg cgb: 8717
      fgae cfgab fg bagce: 4315

  Adding all of the output values in this larger example produces 61229.

  For each entry, determine all of the wire/segment connections and decode the
  four-digit output values. What do you get if you add up all of the output
  values?

  ## Examples

  iex> Advent.DayEight.part_two([
  ...>   [
  ...>     ~w(be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb),
  ...>     ~w(fdgacbe cefdb cefbgd gcbe)
  ...>   ],
  ...>   [~w(edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec), ~w(fcgedb cgb dgebacf gc)],
  ...>   [~w(fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef), ~w(cg cg fdcagb cbg)],
  ...>   [
  ...>     ~w(fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega),
  ...>     ~w(efabcd cedba gadfec cb)
  ...>   ],
  ...>   [
  ...>     ~w(aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga),
  ...>     ~w(gecf egdcabf bgf bfgea)
  ...>   ],
  ...>   [
  ...>     ~w(fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf),
  ...>     ~w(gebdcfa ecba ca fadegcb)
  ...>   ],
  ...>   [
  ...>     ~w(dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf),
  ...>     ~w(cefg dcbef fcge gbcadfe)
  ...>   ],
  ...>   [~w(bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd), ~w(ed bcgafe cdgba cbgef)],
  ...>   [~w(egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg), ~w(gbdfcae bgc cg cgb)],
  ...>   [~w(gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc), ~w(fgae cfgab fg bagce)]
  ...> ])
  61_229
  """
  def part_two([]), do: 0

  def part_two([line | rest]) do
    dictionary = gen_dictionary(line)

    total =
      line
      |> Enum.at(1)
      |> Enum.map(&str_to_set/1)
      |> Enum.map(&Map.get(dictionary, &1))
      |> Enum.join()
      |> String.to_integer()

    total + part_two(rest)
  end

  def gen_dictionary(input) do
    codes =
      input
      |> Enum.concat()
      |> Enum.map(&str_to_set/1)
      |> Enum.uniq()

    eight = Enum.find(codes, &(MapSet.size(&1) == 7))
    one = Enum.find(codes, &(MapSet.size(&1) == 2))
    four = Enum.find(codes, &(MapSet.size(&1) == 4))
    seven = Enum.find(codes, &(MapSet.size(&1) == 3))

    nine = Enum.find(codes, &(MapSet.size(&1) == 6 and MapSet.subset?(four, &1)))

    zero =
      Enum.find(
        codes,
        &(MapSet.size(&1) == 6 and not MapSet.equal?(&1, nine) and MapSet.subset?(seven, &1))
      )

    six =
      Enum.find(
        codes,
        &(MapSet.size(&1) == 6 and not MapSet.equal?(&1, nine) and not MapSet.equal?(&1, zero))
      )

    two = Enum.find(codes, &(MapSet.size(&1) == 5 and not MapSet.subset?(&1, nine)))

    five =
      Enum.find(
        codes,
        &(MapSet.size(&1) == 5 and not MapSet.equal?(&1, two) and MapSet.subset?(&1, six))
      )

    three =
      Enum.find(
        codes,
        &(MapSet.size(&1) == 5 and not MapSet.equal?(&1, two) and not MapSet.equal?(&1, five))
      )

    %{
      one => "1",
      two => "2",
      three => "3",
      four => "4",
      five => "5",
      six => "6",
      seven => "7",
      eight => "8",
      nine => "9",
      zero => "0"
    }
  end

  def str_to_set(str) do
    str
    |> String.to_charlist()
    |> Enum.into(MapSet.new())
  end
end
