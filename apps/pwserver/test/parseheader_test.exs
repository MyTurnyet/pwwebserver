defmodule ParseHeaderTests do
  use ExUnit.Case

  describe "Parse Header Unit Tests" do
    test "to_map/1 should return correct map" do
      header_map = ParseHeader.to_map("My=Data\r\nAuthorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l")

      assert header_map == %{My: "Data", Authorization: "Basic QWxhZGRpbjpPcGVuU2VzYW1l"}
    end

    test "add_headers_to_map/2 should return correct map" do
      header_map =
        ParseHeader.add_headers_to_map(%{}, [
          "My=Data",
          "Authorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l"
        ])

      assert header_map == %{My: "Data", Authorization: "Basic QWxhZGRpbjpPcGVuU2VzYW1l"}
    end

    test "split_line/1 returns correct Array" do
      split_line =
        ParseHeader.split_header("My=Data\r\nAuthorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l")

      assert split_line == ["My=Data", "Authorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l"]
    end
  end
end
