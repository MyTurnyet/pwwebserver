defmodule MethodOptionsController do
  require HeaderStatus
  require HeaderOptions
  require Logger

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def create_response(request_type) do
    case request_type do
      "OPTIONS" -> response_for_option()
      action when action in ["PUT", "GET", "POST", "HEAD"] -> response_for_get()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def response_for_get() do
    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_option() do
    Logger.info("Method Options Controller: OPTIONS")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
    |> HeaderOptions.add_options("GET,HEAD,POST,OPTIONS,PUT")
  end
end
