defmodule C5.KeyValueStore do
  def init do
    HashDict.new
  end

  def start do
    ServerProcess.start(C5.KeyValueStore)
  end

  def put(pid, key, value) do
    ServerProcess.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end

  def handle_call({:get, key}, state) do
    {HashDict.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    HashDict.put(state, key, value)
  end
end
