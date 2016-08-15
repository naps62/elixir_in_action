defmodule Todo.ProcessRegistry do
  import Kernel, except: [send: 2]
  use GenServer

  def start_link do
    IO.puts "Starting process registry"

    GenServer.start_link(__MODULE__, nil, name: :process_registry)
  end

  def register_name(key, pid) do
    GenServer.call(:process_registry, {:register_name, key, pid})
  end

  def whereis_name(key) do
    case :ets.lookup(:todo_process_registry, key) do
      [{^key, pid}] -> pid
      _ -> :undefined
    end
  end

  def unregister_name(key) do
    GenServer.call(:process_registry, {:unregister_name, key})
  end

  def init(_) do
    :ets.new(:todo_process_registry, [:named_table, :protected, :set])

    {:ok, nil}
  end

  def handle_call({:register_name, key, pid}, _, _) do
    case whereis_name(key) do
      :undefined ->
        Process.monitor(pid)
        :ets.insert(:todo_process_registry, {key, pid})
        {:reply, :yes, nil}
      _ ->
        {:reply, :no, nil}
    end
  end

  def handle_call({:unregister_name, key}, _, process_registry) do
    :ets.delete(:todo_process_registry, key)
    {:reply, key, nil}
  end

  def handle_info({:DOWN, _, :process, pid, _}, process_registry) do
    :ets.match_delete(:todo_process_registry, {:_, pid})
    {:noreply, nil}
  end

  def send(key, message) do
    case whereis_name(key) do
      :undefined -> {:badarg, {key, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end
end
