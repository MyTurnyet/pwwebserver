defmodule PutTargetController do
  require HeaderStatus
  require PW.HttpHandler
  require Logger

  def create_response(request_type) do
    case request_type do
      "PUT" -> response_for_put()
      _ -> PW.HttpHandler.send_404_response()
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
