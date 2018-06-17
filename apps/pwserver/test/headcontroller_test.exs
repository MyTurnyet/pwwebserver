defmodule HeadControllerTest do
  use ExUnit.Case
  require HeadController

  describe "HeadController Unit Tests" do
    test "response_for_get/1 should return 200 OK for '/'" do
      response = HeadController.response_for_head("/")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "response_for_get/1 should return 200 OK for '/method_options'" do
      response = HeadController.response_for_head("/method_options")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "response_for_get/1 should return 400 Bad Request for '/foobar'" do
      response = HeadController.response_for_head("/foobar")
      assert response == %{body: "", header: [status: "HTTP/1.1 404 Not Found"]}
    end
  end
end
