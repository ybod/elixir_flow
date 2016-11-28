defmodule Eager do
  def process_file_map(path_to_file) do
    path_to_file
    |> File.read!()
    |> String.split()
    |> Enum.reduce(%{}, fn word, map ->
        word = Words.filter_alphanumeric(word)
        if word != "" do
          word = String.downcase(word)
          Map.update(map, word, 1, &(&1 + 1))
        else
          map
        end
      end)
  end

  def process_file_ets(path_to_file) do
    ets = :ets.new(:words_eager, [])

    path_to_file
    |> File.read!()
    |> String.split()
    |> Enum.each(fn word ->
        word = Words.filter_alphanumeric(word)
        if word != "" do
          word = String.downcase(word)
          :ets.update_counter(ets, word, 1, {word, 0})
        end
       end)

    Ets.ets_to_map(ets)
  end
end
