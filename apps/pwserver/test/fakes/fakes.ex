
defmodule FakeTCPWrapper do
  def recv(socket, _n) do
    PW.FakeSocket.get(socket)
  end
end
