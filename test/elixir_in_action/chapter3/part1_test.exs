defmodule Chapter3.Part1Test do
  alias Chapter3.Part1
  use ExUnit.Case, async: true

  test "list_len" do
    assert Part1.list_len([1, 2, 3]) == 3
  end

  test "list_len" do
    assert Part1.list_len([]) == 0
  end

  test "range" do
    assert Part1.range(0, 0) == []
    assert Part1.range(1, 3) == [1, 2]
  end

  test "positive" do
    assert Part1.positive([-1, 1]) == [1]
  end
end
