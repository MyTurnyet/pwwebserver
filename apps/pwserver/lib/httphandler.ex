
defmodule PW.HttpHandler do
  require Logger

  def add_200_ok_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 200 OK")
  end

  def add_404_not_found_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 404 Not Found")
  end

  def add_418_im_a_teapot_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 418 I'm a teapot")
  end

  def add_404_status_body(response_map) do
    Map.put(response_map, :body, "")
  end

  def add_418_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 12"]
    response_map = Map.put(response_map, :header, header)
   Map.put(response_map, :body, "I'm a teapot")
  end

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def format_response(response_map) do
    header = response_map.header
    response_header = Enum.map_join(header, "\r\n", fn {_, value} -> value end)
    "#{response_header}\r\n\r\n#{response_map.body}"
  end

  def create_response( "/") do
    add_200_ok_status(%{})
    |> add_200_status_body
    |> format_response
  end

  def create_response( "/tea") do
    add_200_ok_status(%{})
    |> add_200_status_body
    |> format_response
  end

  def create_response( "/foobar") do
    add_404_not_found_status(%{})
    |> add_404_status_body
    |> format_response
  end
  def create_response("/coffee") do
    add_418_im_a_teapot_status(%{})
    |> add_418_status_body
    |> format_response
  end
end
