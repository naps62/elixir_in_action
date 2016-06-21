defmodule Chapter4.TodoList do
  alias Chapter4.MultiDict
  alias Chapter4.TodoList
  defstruct auto_id: 1, entries: HashDict.new

  def new, do: %TodoList{}

  def add_entry(
    %TodoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)

    new_entries = HashDict.put(
      entries,
      auto_id,
      entry
    )

    %TodoList{ todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def add_entry(todo_list, entry) do
    MultiDict.add(
      todo_list,
      entry.date,
      entry)
  end

  def entries(
    %TodoList{entries: entries},
    date
  ) do
    entries
    |> Stream.filter(fn({_, entry}) ->
      entry.date == date
    end)
    |> Enum.map(fn({_, entry}) ->
      entry
    end)
  end
end
