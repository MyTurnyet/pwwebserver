defmodule OptionsController do
  require HeaderStatus
  require Logger

  def add_200_status_body(response_map) do
    header = response_map.header
    header = header ++ [content_length: "content-length: 0"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def add_options(response_map, options) do
    header = response_map.header
    header = header ++ [allow: "allow: #{options}"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end

  def response_for_option("/method_options") do
    Logger.info("Found '/method_options'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
    |> add_options("GET,HEAD,POST,OPTIONS,PUT")
  end

  def response_for_option("/method_options2") do
    Logger.info("Found '/method_options2'")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
    |> add_options("GET,OPTIONS,HEAD")
  end
end
