defmodule FormController do
  require HeaderStatus
  require PW.HttpHandler
  require Logger

  def create_response(request_map) do
    case request_map.request_type do
      "POST" -> response_for_post()
      _ -> PW.HttpHandler.send_404_response()
    end
  end

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    Map.put(response_map, :header, header)
    |> BodyFactory.add_empty_body
  end

  def response_for_post() do
    Logger.info("Form Controller: POST")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
