defmodule State.InputBuffer do
  use GenServer
  require Logger

  @initial_state ""
  @eol <<10>>

  def init(args) do
    {:ok, args}
  end
  def create() do
    GenServer.start_link(__MODULE__, @initial_state)
  end

  def recieve(pid \\ __MODULE__, data) do
    GenServer.cast(pid, {:recieve, data})
  end

  def handle_cast({:recieve, data}, buffer) do
    buffer
    |> append(data)
    |> process
  end

  defp append(buffer, ""), do: buffer
  defp append(buffer, data), do: buffer <> data

  defp process(buffer) do
    case extract(buffer) do
      {:statement, buffer, statement} ->
        MessageSink.receive(statement, DateTime.utc_now())
        process(buffer)

      {:nothing, buffer} ->
        {:noreply, buffer}
    end
  end

  defp extract(buffer) do
    case String.split(buffer, @eol, parts: 2) do
      [match, rest] -> {:statement, rest, match}
      [rest] -> {:nothing, rest}
    end
  end
end

defmodule MessageSink do
  def receive(message, time) do
    IO.puts("#{time} #{message}")
  end
end
