alias Flow.Timer

path_to_file = Path.absname("./files/medium.txt")
path_to_dir = Path.absname("./files/parts_medium")

IO.puts("Eager")
Timer.run(Flow, :process_eager, [path_to_file]) |> IO.inspect()

IO.puts("\nLazy")
Timer.run(Flow, :process_lazy, [path_to_file]) |> IO.inspect()


IO.puts("\nFlow - single source")
Timer.run(Flow, :process_flow, [path_to_file]) |> IO.inspect()

IO.puts("\nFlow - multiple sources")
Timer.run(Flow, :process_flow_dir, [path_to_dir]) |> IO.inspect()


IO.puts("\nFlow - global window - count trigger - keep reducer accumulator")
Flow.window_global_trigger(1..1000, 100, :keep) |> IO.inspect()

IO.puts("\nFlow - global window - count trigger - reset reducer accumulator")
Flow.window_global_trigger(1..1000, 100, :reset) |> IO.inspect()
