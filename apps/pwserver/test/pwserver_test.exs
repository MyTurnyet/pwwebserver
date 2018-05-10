defmodule PW.ServerTest do
  use ExUnit.Case
  require Logger


  describe "PW.Server tests" do
    test "Should return status 200 headers for GET" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.read_request(fake_socket, PW.FakeTCPWrapper)

      assert output == "HTTP/1.1 200 OK\r\n\r\n"
    end

    test "create_response/2 should return correct value" do
      fake_resp = {:ok, nil}
      output = PW.Server.create_response(fake_resp)

      assert output == "HTTP/1.1 200 OK\r\n\r\n"
    end

    test "create_response/2 should return {:error, :closed}" do
      fake_resp = {:error, :closed}
      output = PW.Server.create_response(fake_resp)

      assert output == {:error, :closed}
    end

    test "recieve_data/3 should return correct values for :ok status" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])

      output = PW.Server.receive_data(PW.FakeTCPWrapper, fake_socket, [] )

      assert output == {:ok, ["GET / HTTP/1.1\r\n", "Accept: */*\r\n"]}
    end

    test "serve/2 should return http response, " do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.serve(PW.FakeTCPWrapper, fake_socket )
      assert output == "HTTP/1.1 200 OK\r\n\r\n"

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
      PW.FakeSocket.put(pid, ["Bubbles!"])
      assert PW.FakeSocket.get(pid) == {:ok,"Bubbles!"}
    end
  end
end


