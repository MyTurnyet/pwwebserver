defmodule PW.FakeSocket do
  def start(initial) do
    spawn_link(fn -> execute(initial) end)
  end

  def execute(state) do
    receive do
      {:get, sender} ->
        [first | rest] = state
        send(sender, first)
        execute(rest)
    end
  end

  def get(pid) do
    send(pid, {:get, self()})
    receive do
      msg -> {:ok,msg}
    end
  end
end
