defmodule Todo.Database do
  use GenServer

  @pool_size 3

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder, name: :database_server)
  end

  def store(key, data) do
    GenServer.call(:database_server, {:get_worker, key})
    |> GenServer.cast({:store, key, data})
  end

  def get(key) do
    result = GenServer.call(:database_server, {:get_worker, key})
    |> GenServer.call({:store, key})
  end

  def init(db_folder) do
    workers = Enum.reduce(
      1..3,
      %{},
      &(Map.put(&2, &1, Todo.DatabaseWorker.start(db_folder)))
    )

    {:ok, workers}
  end

  def handle_call({:get_worker, key}, _, workers) do
    {:reply, Map.fetch(workers, :erlang.phash2(key, @pool_size)), workers}
  end
end
