defmodule PW.HttpHandlerTest do
  use ExUnit.Case

  describe "PW.HttpHandler unit Tests" do

    test "add_200_ok_status/1 will return 200 OK header" do
      response = PW.HttpHandler.add_200_ok_status(%{})
      headers = response.header
      assert headers[:status] == "HTTP/1.1 200 OK"
    end

    test "add_404_not_found_status/1 will return 404 Not Found" do
      assert PW.HttpHandler.add_404_not_found_status(%{}) == %{header: [status: "HTTP/1.1 404 Not Found"]}
    end

    test "add_418_im_a_teapot_status/1 will return 418 I'm a teapot" do
      assert PW.HttpHandler.add_418_im_a_teapot_status(%{}) == %{header: [status: "HTTP/1.1 418 I'm a teapot"]}
    end

    test "format_response/1 will return the header as a string" do
      output = PW.HttpHandler.format_response(%{path: "/", header: [status: "HTTP/1.1 418 I'm a teapot" ]})
      assert output == "HTTP/1.1 418 I'm a teapot\r\n\r\n"
    end
  end

  describe "PW.HttpHandler integration Tests" do

    test "call to root URL will return 200 OK" do
      response =  PW.HttpHandler.create_response(%{ path: "/"})
      assert response == "HTTP/1.1 200 OK\r\n\r\n"
    end

    test "call to /foobar will return 400 Bad Request" do
      assert PW.HttpHandler.create_response(%{ path: "/foobar"}) == "HTTP/1.1 404 Not Found\r\n\r\n"
    end

    test "call to /coffee will return 418 I'm a teapot with body" do
      assert PW.HttpHandler.create_response( %{ path: "/coffee"}) ==  "HTTP/1.1 418 I'm a teapot\r\n\r\n"
    end

  end
end
