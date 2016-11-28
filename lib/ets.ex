defmodule Ets do
  def ets_to_map(ets) do
    :ets.foldl(fn {key, val}, map ->
      Map.put(map, key, val)
    end, %{}, ets)
  end
end
