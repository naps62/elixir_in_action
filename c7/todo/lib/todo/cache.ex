defmodule Todo.Cache do
  use GenServer

  def init(_) do
    {:ok, HashDict.new}
  end

  # def handle_call({:server_process, todo_list_name}, _, todo_servers)
end
