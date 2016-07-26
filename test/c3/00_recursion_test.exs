defmodule C3.Recursion.Test do
  alias C3.Recursion
  use ExUnit.Case, async: true

  test "list_len/1" do
    assert Recursion.list_len([]) == 0
    assert Recursion.list_len([1, 2, 3]) == 3
    assert Recursion.list_len(Enum.to_list(1..1_000)) == 1_000
  end

  test "range/2" do
    assert Recursion.range(1, 3) == [1, 2, 3]
    assert Recursion.range(1, 1) == [1]
    assert Recursion.range(3, 1) == []
  end

  test "positive/1" do
    assert Recursion.positive([1, 2, 3]) == [1, 2, 3]
    assert Recursion.positive([1, -2, 3]) == [1, 3]
    assert Recursion.positive(["Miguel", -2, 3]) == [3]
  end
end
