defmodule C4.TodoList do
  defstruct auto_id: 1, entries: HashDict.new

  def new, do: %C4.TodoList{}

  def add_entry(
    %C4.TodoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)

    %C4.TodoList{todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def update_entry(
    %C4.TodoList{entries: entries} = todo_list,
    entry_id,
    updater_fun
  ) do
    case entries[entry_id] do
      nil -> todo_list
      old_entry ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = HashDict.put(entries, new_entry.id, new_entry)
        %C4.TodoList{todo_list | entries: new_entries}
    end
  end
 
  def entries(%C4.TodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn({_, entry}) -> entry.date == date end)
    |> Enum.map(fn({_, entry}) -> entry end)
  end
end
