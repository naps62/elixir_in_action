defmodule C3 do
  def lines_length!(path) do
    File.stream!(path)
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(path) do
    File.stream!(path)
    |> Stream.map(&String.length/1)
    |> Enum.max
  end

  def longest_line!(path) do
    File.stream!(path)
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line!(path) do
    File.stream!(path)
    |> Stream.map(&String.split/1)
    |> Enum.map(&length/1)
  end
end
