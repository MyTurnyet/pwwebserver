defmodule PW.FakeTCPWrapper do
  def recv(socket, _n) do
    PW.FakeSocket.get(socket)
  end

  def send(socket, line) do
    PW.FakeSocket.put(socket, line)
  end
end
