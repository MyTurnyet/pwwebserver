defmodule PW.FakeSocket do
  require Logger
  def start(initial) do
    spawn_link(fn -> execute(initial) end)
  end

  def execute(state) do
    receive do
      {:get, sender} ->
        [first | rest] = state
        send(sender, first)
        execute(rest);
      {:put, sender, message} ->
        execute(message);
        send(sender, message)
    end
  end

  def put(pid, message) do
    send(pid, {:put, self(),message})
  end

  def get(pid) do
    send(pid, {:get, self()})
    receive do
      msg -> {:ok,msg}
    end
  end
end
