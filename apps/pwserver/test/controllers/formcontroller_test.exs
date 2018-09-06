defmodule FormControllerTest do
  use ExUnit.Case
  require FormController

  describe "FormController Unit Tests" do
    test "response_for_post should return 200 OK for '/form'" do
      response = FormController.response_for_post()

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "create_response/1 should return 200 OK for 'POST'" do
      request_map = %{path: "/form", request_type: "POST"}
      response = FormController.create_response(request_map)

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
