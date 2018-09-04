defmodule DataState do
  def new do
    Agent.start_link(fn -> "" end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, fn data -> data end)
  end

  def post(new_value) do
    Agent.update(__MODULE__, fn _value -> new_value end)
  end

  def delete() do
    post("")
    Agent.stop(__MODULE__)
  end
end
