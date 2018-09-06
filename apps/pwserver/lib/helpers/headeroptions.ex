defmodule HeaderOptions do
  def add_options(response_map, options) do
    header = response_map.header
    header = header ++ [allow: "allow: #{options}"]
    response_map = Map.put(response_map, :header, header)
    Map.put(response_map, :body, "")
  end
end
