defmodule BodyFactory do
  def add_empty_body(response_map) do
    Map.put(response_map, :body, "")
  end

  def create_body(response_map, body_string) do
    Map.put(response_map, :body, "<html><head></head><body>#{body_string}</body></html>")
  end
end