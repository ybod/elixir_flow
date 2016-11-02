path_to_file = Path.absname("./files/medium.txt")

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


IO.puts("\nFlow - single source")
spawn_link fn ->
  send(parent, { :tc, :timer.tc(Flow, :process_flow, [path_to_file]) })
end

receive do
  { :tc, {timer, map} } ->
    IO.inspect timer / 1_000_000
    IO.inspect map
end


path_to_dir = Path.absname("./files/parts_medium")

IO.puts("\nFlow - multiple sources")
spawn_link fn ->
  send(parent, { :tc, :timer.tc(Flow, :process_flow_dir, [path_to_dir]) })
end

receive do
  { :tc, {timer, map} } ->
    IO.inspect timer / 1_000_000
    IO.inspect map
end
