defmodule C5.GenServerTodo do
  use GenServer

  def init(_) do
    C5.TodoList.new
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
    C5.TodoList.add_entry(todo_list, entry)
  end

  def handle_cast({:update, entry_id, updater_fun}, todo_list) do
    C5.TodoList.update_entry(todo_list, entry_id, updater_fun)
  end

  def handle_call({:entries, date}, todo_list) do
    C5.TodoList.entries(todo_list, date)
  end
end
