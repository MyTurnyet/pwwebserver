defmodule PW.ServerTest do
  use ExUnit.Case
  require Logger


  describe "PW.Server tests" do
    test "Should return status 200 headers for GET" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.read_request(fake_socket, PW.FakeTCPWrapper)
      assert output == "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "create_response/1 should return correct value" do
      url_map = %{path: "/"}
      output = PW.Server.create_response(url_map)
      assert output == "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "recieve_data/3 should return correct values for :ok status" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      output = PW.Server.receive_data(PW.FakeTCPWrapper, fake_socket, [] )
      assert output == {:ok, ["GET / HTTP/1.1\r\n", "Accept: */*\r\n"]}
    end

    test "serve/2 should return http response, " do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      {:put, output} = PW.Server.serve(PW.FakeTCPWrapper, fake_socket )
      assert output ==  "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "serve/2 should write response to the socket" do
      fake_socket = PW.FakeSocket.start(["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"])
      PW.Server.serve(PW.FakeTCPWrapper, fake_socket )
      {:ok, output } = PW.FakeSocket.get_output(fake_socket)
      assert  output ==  "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "parse_request/1 should return root path" do
      request = PW.Server.parse_request({:ok, ["GET / HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"] })
      assert request.path == "/"
    end

    test "parse_request/1 should return /foobar for path" do
      request = PW.Server.parse_request({:ok, ["GET /foobar HTTP/1.1\r\n", "Accept: */*\r\n", "\r\n"] })
      assert request.path == "/foobar"
    end
  end


end


