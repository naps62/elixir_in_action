defmodule C4.TodoList.Test do
  alias C4.TodoList
  use ExUnit.Case, async: true

  test "stores multiple entries for same date" do
    dict = TodoList.new
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2016, 12, 20}, title: "Shopping"})
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Work"})

    stored_values = TodoList.entries(dict, {2016, 12, 19})

    assert length(stored_values) == 2
  end

  test "allows updating the date for an entry" do
    dict = TodoList.new
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2016, 12, 20}, title: "Shopping"})
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Work"})


    updated_dict = TodoList.update_entry(dict, 1, fn(entry) -> %{entry | date: {2016, 12, 1}} end)

    assert length(TodoList.entries(updated_dict, {2016, 12, 1})) == 1
  end

  test "does not allows updating the id for an entry" do
    dict = TodoList.new
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2016, 12, 20}, title: "Shopping"})
      |> TodoList.add_entry(%{date: {2016, 12, 19}, title: "Work"})


    assert_raise MatchError, fn ->
      TodoList.update_entry(dict, 1, fn(entry) -> %{entry | id: 0} end)
    end
  end
end
