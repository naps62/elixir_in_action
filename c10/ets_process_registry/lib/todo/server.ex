defmodule Todo.Server do
  use GenServer

  def start_link(name) do
    IO.puts "Starting to-do server for #{name}"

    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Todo.ProcessRegistry, {:todo_server, name}}
  end

  def whereis(name) do
    Todo.ProcessRegistry.whereis_name({:todo_server, name})
  end

  def init(name) do
    {:ok, {name, Todo.Database.get(name) || Todo.List.new}}
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

  def handle_cast({:add, entry}, {name, todo_list}) do
    new_state = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def handle_cast({:update, entry_id, updater_fun}, {name, todo_list}) do
    new_state = Todo.List.update_entry(todo_list, entry_id, updater_fun)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def handle_call({:entries, date}, _, {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end
end
