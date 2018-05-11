defmodule PW.HttpHandlerTest do
  use ExUnit.Case

  describe "PW.HttpHandler Tests" do

    test "add_200_ok_status/1 will return 200 OK header" do
      assert PW.HttpHandler.add_200_ok_status(%{}) == %{header: "HTTP/1.1 200 OK\r\n\r\n"}
    end

    test "add_404_not_found_status/1 will return 404 Not Found" do
      assert PW.HttpHandler.add_404_not_found_status(%{}) == %{header: "HTTP/1.1 404 Not Found\r\n\r\n"}
    end

    test "add_418_im_a_teapot_status/1 will return 418 I'm a teapot" do
      assert PW.HttpHandler.add_418_im_a_teapot_status(%{}) == %{header: "HTTP/1.1 418 I'm a teapot\r\n\r\n"}
    end
    test "call to root URL will return 200 OK" do
      assert PW.HttpHandler.handle_request(%{ path: "/"}) == %{header: "HTTP/1.1 200 OK\r\n\r\n", path: "/"}
    end

    test "call to /foobar will return 400 Bad Request" do
      assert PW.HttpHandler.handle_request(%{ path: "/foobar"}) == %{header: "HTTP/1.1 404 Not Found\r\n\r\n",path: "/foobar"}
    end

    test "call to /coffee will return 418 I'm a teapot with body" do
      assert PW.HttpHandler.handle_request( %{ path: "/coffee"}) == %{header: "HTTP/1.1 418 I'm a teapot\r\n\r\n", path: "/coffee"}
    end

  end
end
