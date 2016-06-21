defmodule Chapter3 do
  def lines_length!(path) do
    file_stream(path)
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(path) do
    lines_length!(path)
    |> Enum.max
  end

  def longest_line!(path) do
    file_stream(path)
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line!(path) do
    file_stream(path)
    |> Stream.map(&String.split/1)
    |> Enum.map(&length/1)
  end

  defp file_stream(path), do: File.stream!(path)
end
