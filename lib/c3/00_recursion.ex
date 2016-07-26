defmodule C3.TailRecursion do
  def list_len([]), do: 0
  def list_len([_ | t]) do
    1 + list_len(t)
  end

  def range(max, max), do: [max]
  def range(min, max) when min > max, do: []
  def range(min, max) do
    [min | range(min + 1, max)]
  end

  def positive([]), do: []
  def positive([h | t]) when is_number(h) and h > 0 do
    [h | positive(t)]
  end
  def positive([_ | t]) do
    positive(t)
  end
end
