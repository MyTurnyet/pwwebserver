defmodule PW.HttpHandlerTest do
  use ExUnit.Case
  require HeaderStatus

  describe "PW.HttpHandler unit Tests" do

    test "format_response/1 will return the response as a string" do
      output = PW.HttpHandler.format_response(%{path: "/", header: [status: "HTTP/1.1 418 I'm a teapot" ], body: "I'm a teapot"})
      assert output == "HTTP/1.1 418 I'm a teapot\r\n\r\nI'm a teapot"
    end
  end

  describe "PW.HttpHandler integration Tests" do

    test "call to root URL will return 200 OK" do
      response =  PW.HttpHandler.response_for_get( "/")
      assert response == "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to /tea will return 200 OK" do
      response =  PW.HttpHandler.response_for_get( "/tea")
      assert response == "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to /foobar will return 400 Bad Request" do
      assert PW.HttpHandler.response_for_get( "/foobar") == "HTTP/1.1 404 Not Found\r\n\r\n"
    end

    # test "call to /coffee will return 418 I'm a teapot with body" do
    #   assert PW.HttpHandler.response_for_get( "/coffee") ==  "HTTP/1.1 418 I'm a teapot\r\ncontent-lenght: 12\r\n\r\nI'm a teapot"
    # end

  end
end
