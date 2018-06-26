defmodule LogsController do
  require HeaderStatus
  require Logger

  def create_response(request_map) do
    request_type = request_map.request_type
    is_authenticated = request_is_authorized(request_map)
    case request_type do
      "GET" when is_authenticated == false -> unathenticated_response_for_get()
      "GET" when is_authenticated == true -> athenticated_response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def body_text() do
    ""
  end

  def athenticated_response_for_get() do
    Logger.info("Logs Controller: GET - Authorized")
    HeaderStatus.add_200_ok_status(%{})
    |> HeaderStatus.add_empty_response_body()
  end

  def unathenticated_response_for_get() do

    Logger.info("Logs Controller: GET - Unauthorized")
    HeaderStatus.add_401_authenticate_status(%{})
  end

  def request_is_authorized(request_map) do
    Map.has_key?(request_map, :authorization)
  end

  #  def response_for_get(request_map) do
  #
  #    Logger.info("Logs Controller: GET")
  #    HeaderStatus.add_401_authenticate_status(%{})
  #  end
end
