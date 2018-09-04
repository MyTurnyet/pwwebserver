defmodule IndexController do
  require HeaderStatus
  require BodyFactory
  require Logger

  def create_response(request_type) do
    case request_type do
      "GET" -> response_for_get()
      "HEAD" -> response_for_head()
      _ -> HeaderStatus.add_404_not_found_status(%{})
    end
  end

  def add_200_status_body(response_map) do
    header = response_map.header

    Map.put(response_map, :header, header)
    |> BodyFactory.create_body(
      "<a href='/file1'>file1</a><a href='/file2'>file2</a><a href='/image.gif'>image.gif</a><a href='/image.jpeg'>image.jpeg</a><a href='/image.png'>image.png</a><a href='/text-file.txt'>text-file.txt</a>"
    )
    |> HeaderStatus.add_content_length_header()
  end

  def response_for_get() do
    Logger.info("Index Controller: GET")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end

  def response_for_head() do
    Logger.info("Index Controller: HEAD")

    HeaderStatus.add_200_ok_status(%{})
    |> add_200_status_body
  end
end
