defmodule PW.FakeSocket do
  require Logger
  def start(initial) do
    spawn_link(fn -> execute(initial) end)
  end

  def execute(state) do
    Logger.info "State Change: #{state}"
    receive do
      {:get, sender} ->
        [first | rest] = state
        send(sender, first)
        execute(rest);
      {:put, sender} ->
        execute(state)
    end
  end

  def put(pid, msg) do
    send(pid, {:put, msg})
  end

  def get(pid) do
    send(pid, {:get, self()})
    receive do
      msg -> {:ok,msg}
    end
  end
end
