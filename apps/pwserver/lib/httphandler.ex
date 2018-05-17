
defmodule PW.HttpHandler do
  require Logger
  require GetController

  def format_response(response_map) do
    header = response_map.header
    response_header = Enum.map_join(header, "\r\n", fn {_, value} -> value end)
    "#{response_header}\r\n\r\n#{response_map.body}"
  end

  def handle_request(request_map) do
    if request_map.request_type == "GET" do
      GetController.response_for_get(request_map.path)
      |> format_response
    end
  end

end
