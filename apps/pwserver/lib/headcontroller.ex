defmodule HeadController do
  require HeaderStatus
  require Logger

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_head("/") do
    Logger.info("Found HEAD '/'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_head("/method_options") do
    Logger.info("Found HEAD '/method_options'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_head("/foobar") do
    Logger.info("Found HEAD '/foobar'")
    HeaderStatus.add_404_not_found_status(%{})
  end
end
