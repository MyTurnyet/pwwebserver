defmodule ParseHeader do
  require Logger

  def to_map(request_message) do
    add_headers_to_map(%{}, split_header(request_message))
  end

  def add_headers_to_map(header_map, [first_line | remaining_lines]) do
    [map_key, map_value] = String.split(first_line, ~r/:|=/)

    Map.put(header_map, String.to_atom(map_key), String.trim(map_value))
    |> add_headers_to_map(remaining_lines)
  end

  def add_headers_to_map(header_map, []) do
    header_map
  end

  def split_header(header) do
    Logger.info("header to split: #{header}")
    String.split(header, ~r/\r\n/)
  end
end
