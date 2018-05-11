defmodule PW.HttpHandler do
  require Logger

  def handle_request(url) do
    Logger.info("Incoming request: #{url.path}")
    case url.path do
       "/" ->
          "HTTP/1.1 200 OK\r\n\r\n"
        "/foobar" ->
          "HTTP/1.1 400 Bad Request\r\n\r\n"
        nil ->
          "HTTP/1.1 418 I'm a teapot\r\n\r\n"
    end

  end
end
