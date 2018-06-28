defmodule RedirectController do
  require HeaderStatus
  require Logger

  def create_response(request_type) do
    case request_type do
      "GET" -> response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_get() do
    Logger.info("Redirect Controller: GET")

    HeaderStatus.add_302_found_status(%{}, "/")
    |> BodyFactory.add_empty_body
    |> HeaderStatus.add_content_length_header
  end
end
