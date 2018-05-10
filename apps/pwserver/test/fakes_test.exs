defmodule FakesTests do
  use ExUnit.Case
  require Logger

  describe "PW.FakeTCPWrapper tests" do
    test "PW.FakeTCPWrapper should send data" do
      pid = PW.FakeSocket.start(["a", "b", "c"])
      {:put, data} = PW.FakeTCPWrapper.send(pid,"test")
      assert data == "test"
    end
    test "PW.FakeTCPWrapper should get a response" do
      pid = PW.FakeSocket.start(["a", "b", "c"])
      {:ok,data} = PW.FakeTCPWrapper.recv(pid,{})
      assert data == "a"
    end

  end

  describe "PW.FakeSocket tests" do
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

    test "put should push seting to the socket" do
      pid = PW.FakeSocket.start(["q","w","t"])
      PW.FakeSocket.put(pid, "Bubbles!")
      assert PW.FakeSocket.get_output(pid) == {:ok,"Bubbles!"}
    end
  end
end
