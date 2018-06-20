defmodule IndexController do
  require HeaderStatus
  require Logger

  def create_response(request_type) do
    case request_type do
      "GET" -> response_for_get()
      "HEAD" -> response_for_head()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def add_200_status_body(response_map) do
    body_text = ""

    # "<html><head></head><body><a href=\"image.gif\">image.gf</a><a href=\"file2\">file2</a></body>"

    header = response_map.header
    header = header ++ [content_length: "content-length: #{String.length(body_text)}"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, body_text)
  end

  def response_for_get() do
    Logger.info("Index Controller: GET")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_head() do
    Logger.info("Index Controller: HEAD")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
