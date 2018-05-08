defmodule PW.FakeSocketTests do
  use ExUnit.Case

describe "Storage tests" do
  test "gets different values each time" do
    pid = PW.FakeSocket.start(["a", "b", "c"])
    assert PW.FakeSocket.get(pid) == {:ok,"a"}
    assert PW.FakeSocket.get(pid) == {:ok,"b"}
    assert PW.FakeSocket.get(pid) == {:ok,"c"}
  end

  test "allows multiple sockets" do
    pid1 = PW.FakeSocket.start(["a", "b", "c"])
    pid2 = PW.FakeSocket.start(["d", "e", "f"])
    assert PW.FakeSocket.get(pid1) == {:ok,"a"}
    assert PW.FakeSocket.get(pid2) == {:ok,"d"}
  end
end
