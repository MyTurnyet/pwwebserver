defmodule PW.HttpHandler do
  require Logger

  def format_response(response_map) do
    header = response_map.header
    response_header = Enum.map_join(header, "\r\n", fn {_, value} -> value end)
    "#{response_header}\r\n\r\n#{response_map.body}"
  end

  def handle_request(request_map) do

    response_map =
      case request_map.path do
        "/" -> IndexController.create_response(request_map.request_type)
        "/tea" -> TeaController.create_response(request_map.request_type)
        "/coffee" -> CoffeeController.create_response(request_map.request_type)
        "/method_options" -> MethodOptionsController.create_response(request_map.request_type)
        "/method_options2" -> MethodOptions2Controller.create_response(request_map.request_type)
        "/form" -> FormController.create_response(request_map)
        "/put-target" -> PutTargetController.create_response(request_map.request_type)
        "/redirect" -> RedirectController.create_response(request_map.request_type)
        "/logs" -> LogsController.create_response(request_map)
        _ -> send_404_response()
      end

    format_response(response_map)
  end

  def send_404_response() do
    HeaderStatus.add_404_not_found_status(%{})
    |> BodyFactory.add_empty_body
    |> HeaderStatus.add_content_length_header
  end
end
