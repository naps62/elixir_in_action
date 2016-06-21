defmodule Chapter4.TodoList.Test do
  alias Chapter4.TodoList
  use ExUnit.Case, async: true

  test "stores multiple entries for same date" do
    dict = TodoList.new
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Work"})

    stored_values = TodoList.entries(dict, {2016, 12, 19})

    assert length(stored_values) == 2
  end
end
