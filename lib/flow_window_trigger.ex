defmodule Flow.Window.Trigger do
  alias Experimental.Flow

  def global(range, count, accumulator) when accumulator in [:keep, :reset] do
    window =
      Flow.Window.global
      |> Flow.Window.trigger_every(count, accumulator)

    Flow.from_enumerable(range)
    |> Flow.partition(window: window, stages: 1)
    |> Flow.reduce(fn -> 0 end, & &1 + &2)
    |> Flow.emit(:state)
    |> Enum.to_list()
  end
end
