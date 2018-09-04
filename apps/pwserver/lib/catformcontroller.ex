defmodule CatFormController do
  require HeaderStatus
  require Logger
  require BodyFactory

  def create_response(request_map) do
    case request_map.request_type do
      "GET" ->
        response_for_get()

      "POST" ->
        response_for_post("data=foo")

      _ ->
        HeaderStatus.add_404_not_found_status(%{})
        |> BodyFactory.add_empty_body()
        |> HeaderStatus.add_content_length_header()
    end
  end

  def response_for_get() do
    Logger.info("CatForm Controller: GET")
    saved_data = DataState.get()
    Logger.debug("data retreived: #{saved_data}")

    if saved_data != "" do
      HeaderStatus.add_200_ok_status(%{})
      |> BodyFactory.create_body("data=#{saved_data}")
      |> HeaderStatus.add_content_length_header()
    else
      Logger.debug("No Data 404 status")

      HeaderStatus.add_404_not_found_status(%{})
      |> BodyFactory.add_empty_body()
      |> HeaderStatus.add_content_length_header()
    end
  end

  def response_for_post(data_header) do
    Logger.info("CatForm Controller: POST")
    "data=" <> data = data_header
    Logger.debug("data saved: #{data}")

    DataState.post(data)

    HeaderStatus.add_201_created_status(%{}, "/cat-form/data")
    |> BodyFactory.add_empty_body()
    |> HeaderStatus.add_content_length_header()
  end
end
