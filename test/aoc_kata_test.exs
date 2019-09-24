defmodule AocKataTest do
  use ExUnit.Case

  test "day 1 part 1" do
    examples = [
      {~w[+1 -2 +3 +1], 3},
      {~w[+1 +1 +1], 3},
      {~w[+1 +1 -2], 0},
      {~w[-1 -2 -3], -6}
    ]

    for {input, output} <- examples do
      assert AocKata.Day1.resulting_frequency(input) == output
    end
  end

  test "day 1 part 2" do
    examples = [
      {~w[+1 -1], 0},
      {~w[+3 +3 +4 -2 -4], 10},
      {~w[-6 +3 +8 +5 -6], 5},
      {~w[+7 +7 -2 -7 -4], 14}
    ]

    for {input, output} <- examples do
      result = AocKata.Day1.resulting_frequency_fixed(input)
      assert result == output
    end
  end

  test "day 2 part 1" do
    examples = [
      {~w[abcdef bababc abbcde abcccd aabcdd abcdee ababab], 12}
    ]

    for {input, output} <- examples do
      assert AocKata.Day2.checksum(input) == output
    end
  end

  test "day 2 part 2" do
    examples = [
      {~w[abcde fghij klmno pqrst fguij axcye wvxyz], "fgij"}
    ]

    for {input, output} <- examples do
      assert AocKata.Day2.common_letters(input) == output
    end
  end
end
