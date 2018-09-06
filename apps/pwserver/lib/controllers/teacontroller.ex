defmodule TeaController do
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
    Logger.info("Tea Controller: GET")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
