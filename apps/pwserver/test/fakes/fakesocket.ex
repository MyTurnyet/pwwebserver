defmodule PW.FakeSocket do
  require Logger

  def start(initial) do
    spawn_link(fn -> execute({initial, []}) end)
  end

  def execute({input_state, output_state}) do
    receive do
      {:get, sender} ->
        [first | rest] = input_state
        send(sender, first)
        execute({rest, output_state})

      {:get, :output, sender} ->
        send(sender, output_state)
        execute({input_state, []})

      {:put, message} ->
        execute({input_state, message})
    end
  end

  def put(pid, message) do
    send(pid, {:put, message})
  end

  def get(pid) do
    send(pid, {:get, self()})

    receive do
      msg -> {:ok, msg}
    end
  end

  def get_output(pid) do
    send(pid, {:get, :output, self()})

    receive do
      msg -> {:ok, msg}
    end
  end
end
