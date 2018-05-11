defmodule PW.HttpHandlerTest do
  use ExUnit.Case

  describe "PW.HttpHandler Tests" do
    test "call to root URL will return 200 OK" do
      url = %{ path: "/"}
      assert PW.HttpHandler.handle_request(url) == %{header: "HTTP/1.1 200 OK\r\n\r\n"}
    end

    test "call to /foobar will return 400 Bad Request" do
      url = %{ path: "/foobar"}
      assert PW.HttpHandler.handle_request(url) == %{header: "HTTP/1.1 404 Not Found\r\n\r\n"}
    end

    test "call to /coffee will return 418 I'm a teapot with body" do

    end

  end
end
