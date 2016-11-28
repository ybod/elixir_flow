

path_to_file = Path.absname("./files/large.txt")
path_to_dir = Path.absname("./files/parts_large")

# ------- Eager -------
# IO.puts("Eager - Map")
# Timer.run(Eager, :process_file_map, [path_to_file]) |> IO.inspect()

# IO.puts("\nEager - Ets")
# Timer.run(Eager, :process_file_ets, [path_to_file]) |> IO.inspect()


# ------- Lazy -------
IO.puts("\nLazy")
Timer.run(Lazy, :process_file_map, [path_to_file]) |> IO.inspect()

IO.puts("\nLazy - Ets")
Timer.run(Lazy, :process_file_ets, [path_to_file]) |> IO.inspect()

# ------- Flow Maps -------
IO.puts("\nFlow - single source - Maps")
Timer.run(Flow, :process_file_map, [path_to_file]) |> IO.inspect()

IO.puts("\nFlow - multiple sources - Maps")
Timer.run(Flow, :process_dir_map, [path_to_dir]) |> IO.inspect()

# ------- Flow ETS -------
IO.puts("\nFlow - single source - ETS")
Timer.run(Flow, :process_file_ets, [path_to_file]) |> IO.inspect()

IO.puts("\nFlow - multiple sources - ETS")
Timer.run(Flow, :process_dir_ets, [path_to_dir]) |> IO.inspect()

# ------- Flow - Windows/Triggers -------
# IO.puts("\nFlow - global window - count trigger - keep reducer accumulator")
# Flow.Window.Trigger.global(1..1000, 100, :keep) |> IO.inspect()
#
# IO.puts("\nFlow - global window - count trigger - reset reducer accumulator")
# Flow.Window.Trigger.global(1..1000, 100, :reset) |> IO.inspect()
