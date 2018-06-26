defmodule ParseHeader do
  require Logger

  def to_map(request_message) do
    add_headers_to_map(%{}, request_message)
  end

  def add_headers_to_map(header_map, [first_line | remaining_lines]) do

    map_entry = String.replace(first_line, "\r\n", "")
     |> String.split( ~r/:|=/, trim: true, parts: 2 )

    update_header_map(header_map, map_entry)
    |> add_headers_to_map(remaining_lines)
  end

  def update_header_map(header_map, [map_key, map_value]) do
    Map.put(header_map, String.to_atom(map_key), String.trim(map_value))
  end
  def update_header_map(header_map, []) do
    header_map
  end

  def add_headers_to_map(header_map, []) do
    header_map
  end
end
