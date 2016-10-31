path_to_file = Path.absname("./files/small.txt")

parent = self


IO.puts("Eager")
spawn_link fn ->
  send(parent, { :tc, :timer.tc(Flow, :process_eager, [path_to_file]) })
end

receive do
  { :tc, {timer, map} } ->
    IO.inspect timer / 1_000_000
    IO.inspect map
end


IO.puts("\nLazy")
spawn_link fn ->
  send(parent, { :tc, :timer.tc(Flow, :process_lazy, [path_to_file]) })
end

receive do
  { :tc, {timer, map} } ->
    IO.inspect timer / 1_000_000
    IO.inspect map
end


IO.puts("\nFlow")
spawn_link fn ->
  send(parent, { :tc, :timer.tc(Flow, :process_flow, [path_to_file]) })
end

receive do
  { :tc, {timer, map} } ->
    IO.inspect timer / 1_000_000
    IO.inspect map
end
