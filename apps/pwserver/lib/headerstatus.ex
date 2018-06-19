defmodule HeaderStatus do
  def add_200_ok_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 200 OK")
  end

  def add_404_not_found_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 404 Not Found")
    |> add_404_status_body
  end

  def add_302_found_status(response_map, redirect_location) do
    Map.put(response_map, :header, status: "HTTP/1.1 302")
    |> add_302_redirect_location(redirect_location)
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

  def add_302_redirect_location(response_map, redirect_location) do
    header = response_map.header
    header = header ++ [location: "location: #{redirect_location}"]
    Map.put(response_map, :header, header)
  end
end
