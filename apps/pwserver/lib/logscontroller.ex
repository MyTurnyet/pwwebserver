defmodule LogsController do
  require HeaderStatus
  require Logger

  def create_response(request_map) do
    request_type = request_map.request_type
    is_authenticated = request_is_authorized(request_map)

    case request_type do
      "GET" when is_authenticated == false -> unauthenticated_response_for_get()
      "GET" when is_authenticated == true -> authenticated_response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def body_text() do
    ""
  end
  def body_with_logs() do
    "<html><head></head><body>
    GET /log HTTP/1.1<br/>
    PUT /these HTTP/1.1<br/>
    HEAD /requests HTTP/1.1<br/>
    </body></html>"
  end

  def authenticated_response_for_get() do
    Logger.info("Logs Controller: GET - Authorized")

    HeaderStatus.add_200_ok_status(%{})
    |> Map.put(:body, body_with_logs())
    |> HeaderStatus.add_content_length_header
  end

  def unauthenticated_response_for_get() do
    Logger.info("Logs Controller: GET - Unauthorized")
    HeaderStatus.add_401_authenticate_status(%{})
  end

  def request_is_authorized(request_map) do
    Map.has_key?(request_map.headers, :Authorization)
  end

end
