defmodule Lazy do
  def process_file_map(path_to_file) do
    path_to_file
    |> File.stream!(read_ahead: 100_000)
    |> Stream.flat_map(&String.split(&1, Words.pattern))
    |> Stream.map(&Words.filter_alphanumeric/1)
    |> Stream.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Enum.reduce(%{}, fn word, map ->
          Map.update(map, word, 1, &(&1 + 1))
      end)
  end

  def process_file_ets(path_to_file) do
    ets = :ets.new(:words_lazy, [])

    path_to_file
    |> File.stream!(read_ahead: 100_000)
    |> Stream.flat_map(&String.split(&1, Words.pattern))
    |> Stream.map(&Words.filter_alphanumeric/1)
    |> Stream.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Enum.each(fn word -> :ets.update_counter(ets, word, 1, {word, 0}) end)

    Ets.ets_to_map(ets)
  end
end
