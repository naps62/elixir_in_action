defmodule C3.Recursion do
  def list_len(l), do: do_list_len(l, 0)

  defp do_list_len([], n), do: n
  defp do_list_len([_ | t], n) do
    do_list_len(t, n + 1)
  end

  def range(min, max), do: do_range(min, max, [])

  defp do_range(min, max, _) when min > max, do: []
  defp do_range(max, max, list) do
    Enum.reverse([max | list])
  end
  defp do_range(min, max, list) do
    do_range(min + 1, max, [min | list])
  end

  def positive(l), do: do_positive(l, [])

  defp do_positive([], result) do
    Enum.reverse(result)
  end
  defp do_positive([h | t], result) when is_number(h) and h > 0 do
    do_positive(t, [h | result])
  end
  defp do_positive([_ | t], result) do
    do_positive(t, result)
  end
end
