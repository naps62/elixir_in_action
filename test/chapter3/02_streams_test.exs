defmodule Chapter3Test do
  use ExUnit.Case, async: true

  test "lines_length!" do
    (Chapter3.lines_length!("test_file.txt") == [2, 3, 4, 8])
    |> assert
  end

  test "longest_line_length!" do
    (Chapter3.longest_line_length!("test_file.txt") == 8)
    |> assert
  end

  test "longest_line!" do
    (Chapter3.longest_line!("test_file.txt") == "123 321\n")
    |> assert
  end

  test "words_per_line!" do
    (Chapter3.words_per_line!("test_file.txt") == [1, 1, 1, 2])
    |> assert
  end
end
