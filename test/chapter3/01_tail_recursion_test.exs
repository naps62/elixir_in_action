defmodule Chapter3.TailRecursion.Test do
  alias Chapter3.TailRecursion
  use ExUnit.Case, async: true

  test "list_len/1" do
    assert TailRecursion.list_len([]) == 0
    assert TailRecursion.list_len([1, 2, 3]) == 3
    assert TailRecursion.list_len(Enum.to_list(1..1_000)) == 1_000
  end

  test "range/2" do
    assert TailRecursion.range(1, 3) == [1, 2, 3]
    assert TailRecursion.range(1, 1) == [1]
    assert TailRecursion.range(3, 1) == []
  end

  test "positive/1" do
    assert TailRecursion.positive([1, 2, 3]) == [1, 2, 3]
    assert TailRecursion.positive([1, -2, 3]) == [1, 3]
    assert TailRecursion.positive(["Miguel", -2, 3]) == [3]
  end
end
