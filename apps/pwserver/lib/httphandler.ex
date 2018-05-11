defmodule PW.HttpHandler do
  require Logger

  def handle_request(request_map) do
    Logger.info("Incoming request: #{request_map.path}")
    response_map = %{path: request_map.path}
    case request_map.path do
       "/" ->
          add_200_ok_status(response_map)
        "/coffee" ->
          add_418_im_a_teapot_status(response_map)
        _ ->
          add_404_not_found_status(response_map)
    end
  end

  def add_200_ok_status(response_map) do
    Map.put(response_map, :header,  "HTTP/1.1 200 OK\r\n\r\n")
  end

  def add_404_not_found_status(response_map) do
    Map.put(response_map, :header,"HTTP/1.1 404 Not Found\r\n\r\n")
  end

  def add_418_im_a_teapot_status(response_map) do
    Map.put(response_map, :header,"HTTP/1.1 418 I'm a teapot\r\n\r\n")
  end
end
