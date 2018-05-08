defmodule PW.ServerTest do
  use ExUnit.Case

describe "Storage tests" do
  test "gets different values each time" do
    pid = FakeSocket.start(["a", "b", "c"])
    assert FakeSocket.get(pid) == {:ok,"a"}
    assert FakeSocket.get(pid) == {:ok,"b"}
    assert FakeSocket.get(pid) == {:ok,"c"}
  end

  test "allows multiple sockets" do
    pid1 = FakeSocket.start(["a", "b", "c"])
    pid2 = FakeSocket.start(["d", "e", "f"])
    assert FakeSocket.get(pid1) == {:ok,"a"}
    assert FakeSocket.get(pid2) == {:ok,"d"}
  end
end
