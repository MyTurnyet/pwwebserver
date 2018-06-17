defmodule FormController do
  require HeaderStatus
  require Logger

  def create_response(request_map) do
    case request_map.request_type do
      "POST" -> response_for_post()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_post() do
    Logger.info("Form Controller: POST")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
