defmodule PutTargetController do
  require HeaderStatus
  require Logger

  def create_response(request_type) do
    case request_type do
      "PUT" -> response_for_put()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_put() do
    Logger.info("PutTarget Controller: PUT")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
