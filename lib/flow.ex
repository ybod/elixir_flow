defmodule Flow do
  alias Experimental.Flow

  def process_file_map(path_to_file) do
    path_to_file
    |> File.stream!(read_ahead: 100_000)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, Words.pattern))
    |> Flow.map(&Words.filter_alphanumeric/1)
    |> Flow.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, map ->
        Map.update(map, word, 1, &(&1 + 1))
       end)
    |> Enum.into(%{})
  end

  def process_dir_map(path_to_dir) do
    streams = for file <- File.ls!(path_to_dir) do
      File.stream!(path_to_dir <> "/" <> file, read_ahead: 100_000)
    end

    streams
    |> Flow.from_enumerables()
    |> Flow.flat_map(&String.split(&1, Words.pattern))
    |> Flow.map(&Words.filter_alphanumeric/1)
    |> Flow.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, map ->
        Map.update(map, word, 1, &(&1 + 1))
       end)
    |> Enum.into(%{})
  end

  # ------- ETS -------

  def process_file_ets(path_to_file) do
    path_to_file
    |> File.stream!(read_ahead: 100_000)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, Words.pattern))
    |> Flow.map(&Words.filter_alphanumeric/1)
    |> Flow.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> :ets.new(:words_flow, []) end, fn word, ets ->
        :ets.update_counter(ets, word, 1, {word, 0})
        ets
       end)
    |> Flow.map_state(fn ets -> Ets.ets_to_map(ets) end)
    |> Enum.into(%{})
  end

  def process_dir_ets(path_to_dir) do
    streams = for file <- File.ls!(path_to_dir) do
      File.stream!(path_to_dir <> "/" <> file, read_ahead: 100_000)
    end

    streams
    |> Flow.from_enumerables()
    |> Flow.flat_map(&String.split(&1, Words.pattern))
    |> Flow.map(&Words.filter_alphanumeric/1)
    |> Flow.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> :ets.new(:words_flow_dir, []) end, fn word, ets ->
        :ets.update_counter(ets, word, 1, {word, 0})
        ets
       end)
    |> Flow.map_state(fn ets -> Ets.ets_to_map(ets) end)
    |> Enum.into(%{})
  end
end
