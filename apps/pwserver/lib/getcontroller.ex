defmodule GetController do
  require HeaderStatus
  require Logger

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_get("/") do
    Logger.info("Found '/'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_get("/tea") do
    Logger.info("Found '/tea'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_get("/foobar") do
    Logger.info("Found '/foobar'")
    HeaderStatus.add_404_not_found_status(%{})
  end

  def response_for_get("/coffee") do
    Logger.info("Found '/coffee'")

    HeaderStatus.add_418_im_a_teapot_status(%{})
    |> HeaderStatus.add_418_status_body()
  end
end
