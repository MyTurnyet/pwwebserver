defmodule IndexControllerTest do
  use ExUnit.Case
  require IndexController

  describe "GetController Unit Tests" do
    test "create_response/1 should return 200 OK for 'GET'" do
      response = IndexController.create_response("GET")

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_get/1 should return 200 OK for '/'" do
      response = IndexController.response_for_get()

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_head/1 should return 200 OK for '/'" do
      response = IndexController.response_for_head()

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end
  end
end
