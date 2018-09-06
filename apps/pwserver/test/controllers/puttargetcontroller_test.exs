defmodule PutTargetControllerTest do
  use ExUnit.Case
  require PutTargetController

  describe "PutTarget Controller Unit Tests" do
    test "create_response/1 should return 200 OK for 'PUT'" do
      response = PutTargetController.create_response("PUT")

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_get/1 should return 200 OK for '/put-target'" do
      response = PutTargetController.response_for_put()

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end
  end
end
