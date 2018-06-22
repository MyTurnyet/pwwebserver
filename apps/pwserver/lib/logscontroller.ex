defmodule LogsController do
  require HeaderStatus
  require Logger

  def create_response(request_map) do
    request_type = request_map.request_type

    case request_type do
      "GET" -> response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def body_text() do
    ""
  end

  def response_for_get() do
    Logger.info("Logs Controller: GET")
    HeaderStatus.add_401_authenticate_status(%{})
  end
end
