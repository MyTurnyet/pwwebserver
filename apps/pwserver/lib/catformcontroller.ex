defmodule CatFormController do
  require HeaderStatus
  require Logger
  require BodyFactory


  def response_for_get() do
    Logger.info("Coffee Controller: GET")

#    if data == [] do
#      HeaderStatus.add_200_ok_status(%{})
#      |> BodyFactory.create_body("")
#      |> HeaderStatus.add_content_length_header
#    else
      HeaderStatus.add_404_not_found_status(%{})
      |> BodyFactory.add_empty_body
      |> HeaderStatus.add_content_length_header
#    end
  end

  def response_for_post(data) do
    Logger.info("Coffee Controller: POST")

    HeaderStatus.add_201_created_status(%{}, "/cat-form/data")
    |> BodyFactory.add_empty_body
    |> HeaderStatus.add_content_length_header
  end

end