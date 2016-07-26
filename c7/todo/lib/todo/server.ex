defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(Todo.Server, nil)
  end

  def init(_) do
    {:ok, Todo.List.new}
  end

  def add_entry(server, entry) do
    GenServer.cast(server, {:add, entry})
  end

  def update_entry(server, entry_id, updater_fun) do
    GenServer.cast(server, {:update, entry_id, updater_fun})
  end

  def entries(server, date) do
    GenServer.call(server, {:entries, date})
  end

  def handle_cast({:add, entry}, todo_list) do
    Todo.List.add_entry(todo_list, entry)
  end

  def handle_cast({:update, entry_id, updater_fun}, todo_list) do
    Todo.List.update_entry(todo_list, entry_id, updater_fun)
  end

  def handle_call({:entries, date}, _, todo_list) do
    {:reply, Todo.List.entries(todo_list, date), todo_list}
  end
end
