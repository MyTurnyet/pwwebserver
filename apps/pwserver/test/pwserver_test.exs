defmodule PW.ServerTest do
  use ExUnit.Case
  require Logger


  defmodule FakeSocket do
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

  defmodule FakeTCPWrapper do
    def recv(socket, _n) do
      FakeSocket.get(socket)
    end
  end

  describe "PW.Server tests" do
    test "Should return status 200 headers for GET" do
      fake_socket = FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.read_request(fake_socket, FakeTCPWrapper)


      assert output == "HTTP/1.1 200 OK\r\n\r\n"
    end


  end
end
