defmodule Chapter3.Part1 do
  def list_len(list), do: do_list_len(list, 0)

  defp do_list_len([], n), do: n
  defp do_list_len([_ | t], n) do
    do_list_len(t, n + 1)
  end

  def range(n, n), do: []
  def range(from, to) when from < to do
    [from | range(from + 1, to)]
  end

  def positive(l), do: do_positive(l, [])

  defp do_positive([], result), do: result
  defp do_positive([h | t], result) when is_number(h) and h > 0 do
    do_positive(t, [ h | result])
  end
  defp do_positive([_ | t], result) do
    do_positive(t, result)
  end
end
