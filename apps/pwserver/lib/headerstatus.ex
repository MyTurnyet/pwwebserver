defmodule HeaderStatus do
  require BodyFactory

#  def add_empty_response_body(response_map) do
#    BodyFactory.add_empty_body(response_map)
#    |> add_content_length_header
#  end

  def add_content_length_header(response_map) do
    content_length = String.length(response_map.body)
    header_map = response_map.header
    header_map = header_map ++ [content_length: "content-length: #{content_length}"]
    Map.put(response_map, :header, header_map)
  end

  def add_200_ok_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 200 OK")
  end
  def add_201_created_status(response_map, redirect_location) do
    Map.put(response_map, :header, status: "HTTP/1.1 201 Created")
    |>add_location_header(redirect_location)
  end
  def add_302_found_status(response_map, redirect_location) do
    Map.put(response_map, :header, status: "HTTP/1.1 302")
    |> add_location_header(redirect_location)
  end

  def add_location_header(response_map, redirect_location) do
    header = response_map.header
    header = header ++ [location: "location: #{redirect_location}"]
    Map.put(response_map, :header, header)
  end

  def add_401_authenticate_realm(response_map) do
    header = response_map.header
    header = header ++ [www_authenticate: "WWW-Authenticate: Basic realm=\"User Visible Realm\""]
    Map.put(response_map, :header, header)
  end

  def add_401_authenticate_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 401 Unauthorized")
    |> add_401_authenticate_realm
#    |> add_empty_response_body
  end

  def add_404_not_found_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 404 Not Found")
#    |> add_empty_response_body
  end

  def add_418_im_a_teapot_status(response_map) do
    Map.put(response_map, :header, status: "HTTP/1.1 418 I'm a teapot")
  end

  def add_418_status_body(response_map) do
    header = response_map.header
    Map.put(response_map, :header, header)
    |> BodyFactory.create_body("I'm a teapot")
    |> add_content_length_header
  end
end
