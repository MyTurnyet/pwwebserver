defmodule PW.ServerTest do
  use ExUnit.Case
  require Logger


  describe "PW.Server tests" do
    test "Should return status 200 headers for GET" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.read_request(fake_socket, FakeTCPWrapper)

      assert output == "HTTP/1.1 200 OK\r\n\r\n"
    end
  end
end


