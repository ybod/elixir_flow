defmodule Flow do
  alias Experimental.Flow

  def process_eager(path_to_file) do
    path_to_file
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.replace(&1, ~r/\W/u, ""))
    |> Enum.filter_map(fn s -> s != "" end, &String.downcase/1)
    |> Enum.reduce(%{}, fn word, map ->
        Map.update(map, word, 1, &(&1 + 1))
      end)
  end

  def process_lazy(path_to_file) do
    path_to_file
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.replace(&1, ~r/\W/u, ""))
    |> Stream.filter_map(fn s -> s != "" end, &String.downcase/1)
    |> Enum.reduce(%{}, fn word, map ->
        Map.update(map, word, 1, &(&1 + 1))
      end)
  end

  def process_flow(path_to_file) do
    path_to_file
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split/1)
    |> Flow.map(&String.replace(&1, ~r/\W/u, ""))
    |> Flow.filter_map(fn s -> s != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, map ->
      Map.update(map, word, 1, &(&1 + 1))
    end)
    |> Enum.into(%{})
  end
end
