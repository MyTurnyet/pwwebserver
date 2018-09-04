defmodule Cookiecontroller do
  require HeaderStatus
  require BodyFactory
  require Logger

  def create_response(request_map) do
    case request_map.request_type do
      "GET" -> response_for_get()
      _ -> PW.HttpHandler.send_404_response()
    end
  end

  def add_response_body(response_map) do
    Map.put(response_map, :body, "")
  end

  def response_for_get() do
    Logger.info("Cookie Controller: GET")

    HeaderStatus.add_200_ok_status(%{})
    |> BodyFactory.create_body("Eat<br/>mmmm chocolate")
    |> HeaderStatus.add_content_length_header()
  end
end
