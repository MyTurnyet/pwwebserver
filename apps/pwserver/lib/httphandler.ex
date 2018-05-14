
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

  def format_response(response_map) do
    header = response_map.header
    response_string = Enum.map_join(header, "\r\n", fn {_, value} -> value end)
    Logger.info("response_string = #{response_string}")
    "#{response_string}\r\n\r\n"
  end

  def create_response( %{path: "/"}) do
    add_200_ok_status(%{})
    |> format_response
  end
  def create_response( %{path: "/foobar"}) do
    add_404_not_found_status(%{})
    |> format_response
  end
  def create_response( %{path: "/coffee"}) do
    add_418_im_a_teapot_status(%{})
    |> format_response
  end
end
