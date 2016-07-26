defmodule C5.TodoServer do
  def init do
    C5.TodoList.new
  end

  def start do
    ServerProcess.start(C5.TodoServer)
  end

  def add_entry(todo_server, entry) do
    ServerProcess.cast(todo_server, {:add, entry})
  end

  def update_entry(pid, entry_id, updater_fun) do
    ServerProcess.cast(pid, {:update, entry_id, updater_fun})
  end

  def entries(pid, date) do
    ServerProcess.call(pid, {:entries, date})
  end

  def handle_cast({:add, entry}, todo_list) do
    C5.TodoList.add_entry(todo_list, entry)
  end

  def handle_cast({:update, entry_id, updater_fun}, todo_list) do
    C5.TodoList.add_entry(todo_list, entry_id, updater_fun)
  end

  def handle_call({:entries, date}, todo_list) do
    {C5.TodoList.entries(todo_list, date), todo_list}
  end
end

defmodule C5.TodoList do
  defstruct auto_id: 1, entries: HashDict.new

  def new do
    %C5.TodoList{}
  end

  def add_entry(
    %C5.TodoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)
    %C5.TodoList{todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def update_entry(
    %C5.TodoList{entries: entries} = todo_list,
    entry_id,
    updater_fun
  ) do
    case entries[entry_id] do
      nil -> todo_list
      old_entry ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = HashDict.put(entries, new_entry.id, new_entry)
        %C5.TodoList{todo_list | entries: new_entries}
    end
  end

  def entries(%C5.TodoList{entries: entries} = todo_list, date) do
    response = entries
    |> Stream.filter(fn({_, entry}) -> entry.date == date end)
    |> Enum.map(fn({_, entry}) -> entry end)
  end
end
