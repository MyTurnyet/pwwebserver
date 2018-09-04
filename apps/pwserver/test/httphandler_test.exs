defmodule PW.HttpHandlerTest do
  use ExUnit.Case
  require HeaderStatus

  describe "PW.HttpHandler unit Tests" do
    test "format_response/1 will return the response as a string" do
      output =
        PW.HttpHandler.format_response(%{
          path: "/",
          header: [
            status: "HTTP/1.1 418 I'm a teapot"
          ],
          body: "<html><head></head><body>I'm a teapot</body></html>"
        })

      assert output ==
               "HTTP/1.1 418 I'm a teapot\r\n\r\n<html><head></head><body>I'm a teapot</body></html>"
    end
  end

  describe "PW.HttpHandler integration Tests" do
    test "call to '/' will return 200 OK" do
      request_map = %{path: "/", request_type: "GET"}
      response = PW.HttpHandler.handle_request(request_map)

      assert response ==
               "HTTP/1.1 200 OK\r\ncontent-length: 237\r\n\r\n<html><head></head><body><a href='/file1'>file1</a><a href='/file2'>file2</a><a href='/image.gif'>image.gif</a><a href='/image.jpeg'>image.jpeg</a><a href='/image.png'>image.png</a><a href='/text-file.txt'>text-file.txt</a></body></html>"
    end

    test "call to /cat-form/data will return 404 Not Found when DataState is not set" do
      DataState.new()
      DataState.post("")
      request_map = %{path: "/cat-form/data", request_type: "GET"}
      response = PW.HttpHandler.handle_request(request_map)
      assert response == "HTTP/1.1 404 Not Found\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to /cat-form will return 201 Created" do
      DataState.post("working!")
      request_map = %{path: "/cat-form", request_type: "POST"}
      response = PW.HttpHandler.handle_request(request_map)

      assert response ==
               "HTTP/1.1 201 Created\r\nlocation: /cat-form/data\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to '/cookie?type=chocolate' will return 200 OK" do
      request_map = %{path: "/cookie", request_type: "GET", querystring: ["type=chocolate"]}
      response = PW.HttpHandler.handle_request(request_map)

      assert response ==
               "HTTP/1.1 200 OK\r\ncontent-length: 61\r\n\r\n<html><head></head><body>Eat<br/>mmmm chocolate</body></html>"
    end

    test "call to /tea will return 200 OK" do
      request_map = %{path: "/tea", request_type: "GET"}
      response = PW.HttpHandler.handle_request(request_map)
      assert response == "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to /coffee will return 418 I'm a teapot with body" do
      request_map = %{path: "/coffee", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 418 I'm a teapot\r\ncontent-length: 51\r\n\r\n<html><head></head><body>I'm a teapot</body></html>"
    end

    test "GET call to /method_options will return 200 OK" do
      request_map = %{path: "/method_options", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "PUT call to /method_options will  return 200 OK" do
      request_map = %{path: "/method_options", request_type: "PUT"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "POST call to /method_options will  return 200 OK" do
      request_map = %{path: "/method_options", request_type: "POST"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "HEAD call to /method_options will  return 200 OK" do
      request_map = %{path: "/method_options", request_type: "HEAD"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "OPTIONS call to /method_options will  return 200 OK" do
      request_map = %{path: "/method_options", request_type: "OPTIONS"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\nallow: GET,HEAD,POST,OPTIONS,PUT\r\n\r\n"
    end

    test "OPTIONS call to /method_options2 will  return 200 OK" do
      request_map = %{path: "/method_options2", request_type: "OPTIONS"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\nallow: GET,OPTIONS,HEAD\r\n\r\n"
    end

    test "POST call to /form will  return 200 OK" do
      request_map = %{path: "/form", request_type: "POST"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "GET call to /form will  return 400 Bad Request" do
      request_map = %{path: "/form", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 404 Not Found\r\ncontent-length: 0\r\n\r\n"
    end

    test "PUT call to /put-target will  return 200 OK" do
      request_map = %{path: "/put-target", request_type: "PUT"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 200 OK\r\ncontent-length: 0\r\n\r\n"
    end

    test "GET call to /put-target will  return 400 Bad Request" do
      request_map = %{path: "/put-target", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 404 Not Found\r\ncontent-length: 0\r\n\r\n"
    end

    test "GET call to /redirect will return 302 redirect" do
      request_map = %{path: "/redirect", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 302\r\nlocation: /\r\ncontent-length: 0\r\n\r\n"
    end

    test "call to /foobar will return 400 Bad Request" do
      request_map = %{path: "/foobar", request_type: "GET"}

      assert PW.HttpHandler.handle_request(request_map) ==
               "HTTP/1.1 404 Not Found\r\ncontent-length: 0\r\n\r\n"
    end
  end
end
