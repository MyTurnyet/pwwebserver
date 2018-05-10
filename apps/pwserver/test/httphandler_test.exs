defmodule PW.HttpHandlerTest do
  use ExUnit.Case

  describe "PW.HttpHandler Tests" do
    test "foo" do
      http_response = PW.HttpHandler.handle_request("http://localhost:8091")
      assert http_response = "HTTP/1.1 200 OK\r\n\r\n"
    end
  end
end
