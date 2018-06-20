defmodule IndexControllerTest do
  use ExUnit.Case

  def body_text do
    ""
  end

  describe "Index Controller Unit Tests" do
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
                 body: body_text,
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_head/1 should return 200 OK for '/'" do
      response = IndexController.response_for_head()

      assert response ==
               %{
                 body: body_text,
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end
  end
end
