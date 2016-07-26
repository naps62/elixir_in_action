defmodule C4.MultiDict.Test do
  alias C4.MultiDict
  use ExUnit.Case, async: true

  test "stores elements" do
    dict = MultiDict.new
      |> MultiDict.add("key", "value")

    stored_values = MultiDict.get(dict, "key")

    assert stored_values == ["value"]
  end

  test "stores multiple elements for same key" do
    dict = MultiDict.new
      |> MultiDict.add("key", "value")
      |> MultiDict.add("key", "other_value")

    stored_values = MultiDict.get(dict, "key")

    assert stored_values == ["other_value", "value"]
  end
end
