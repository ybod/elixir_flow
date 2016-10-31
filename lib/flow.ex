defmodule Flow do
  alias Experimental.Flow

  def process_eager(path_to_file) do
    path_to_file
    |> File.read!()
    |> String.split()
    |> Enum.reduce(%{}, &words_to_map/2)
  end

  def process_lazy(path_to_file) do
    path_to_file
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Enum.reduce(%{}, &words_to_map/2)
  end

  defp words_to_map(word, map) do
    word
    |> String.replace(~r/\W/u, "")
    |> filter_map(map)
  end

  defp filter_map("", map), do: map
  defp filter_map(word, map) do
    word = String.downcase(word)
    Map.update(map, word, 1, &(&1 + 1))
  end


  def process_flow(path_to_file) do
    path_to_file
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split/1)
    |> Flow.map(&String.replace(&1, ~r/\W/u, ""))
    |> Flow.filter_map(fn w -> w != "" end, &String.downcase/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, map ->
        Map.update(map, word, 1, &(&1 + 1))
       end)
    |> Enum.into(%{})
  end
end
