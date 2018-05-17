defmodule GetControllerTest do
  use ExUnit.Case
  require GetController

  describe "GetController Unit Tests" do
    test "response_for_get/1 should return 200 OK for '/'" do
      response = GetController.response_for_get("/")

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_get/1 should return 200 OK for '/tea'" do
      response = GetController.response_for_get("/tea")

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end

    test "response_for_get/1 should return 400 Bad Request for '/foobar'" do
      response = GetController.response_for_get("/foobar")
      assert response == %{body: "", header: [status: "HTTP/1.1 404 Not Found"]}
    end

    test "response_for_get/1 should return 400 Bad Request for '/coffee'" do
      response = GetController.response_for_get("/coffee")

      assert response ==
               %{
                 body: "I'm a teapot",
                 header: [
                   status: "HTTP/1.1 418 I'm a teapot",
                   content_length: "content-length: 12"
                 ]
               }
    end
  end
end
