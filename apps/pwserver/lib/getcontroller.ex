defmodule GetController do
  require HeaderStatus

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_get( "/") do
    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
    # |> format_response
  end

  def response_for_get( "/tea") do
    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
    # |> format_response
  end

  def response_for_get( "/foobar") do
    HeaderStatus.add_404_not_found_status(%{})
    # |> HeaderStatus.add_404_status_body
    # |> format_response
  end
  def response_for_get("/coffee") do
    HeaderStatus.add_418_im_a_teapot_status(%{})
    |> HeaderStatus.add_418_status_body
    # |> format_response
  end
end
