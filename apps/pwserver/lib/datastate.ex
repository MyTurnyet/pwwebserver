defmodule DataState do

  def new do
    Agent.start_link(fn -> "" end)
  end

  def get(pid) do
    Agent.get(pid, fn (data) -> data end)
  end

  def post(pid, new_value) do
    Agent.update(pid, fn(_value)-> new_value  end)
  end

  def delete(pid) do
    post(pid,"")
    Agent.stop(pid)
  end
end