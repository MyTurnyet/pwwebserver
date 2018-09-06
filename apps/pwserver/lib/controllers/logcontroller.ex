defmodule LogController do
  require HeaderStatus
  require Logger

  def create_response(request_type) do
    case request_type do
      "GET" -> response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def body_text() do
    ""
  end

  def response_for_get() do
    Logger.info("Log Controller: GET")
    HeaderStatus.add_200_ok_status(%{})
  end
end
