defmodule PW.HttpHandler do
  require Logger

  def handle_request(request_map) do
    Logger.info("Incoming request: #{request_map.path}")
    response_map = %{}
    case request_map.path do
       "/" ->
          Map.put(response_map, :header,  "HTTP/1.1 200 OK\r\n\r\n")
        "/foobar" ->
          Map.put(response_map, :header,  "HTTP/1.1 404 Not Found\r\n\r\n")
        "/coffee" ->
          Map.put(response_map, :header,"HTTP/1.1 418 I'm a teapot\r\n\r\n")
        _ ->
          Map.put(response_map, :header,"HTTP/1.1 404 Not Found\r\n\r\n")
    end

  end
end
