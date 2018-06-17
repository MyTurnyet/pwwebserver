defmodule OptionsControllerTest do
  use ExUnit.Case
  require MethodOptionsController

  describe "MethodOptionsController Unit Tests" do
    test "create_response/1 should return 200 OK for 'OPTIONS'" do
      response = MethodOptionsController.create_response("OPTIONS")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0",
                   allow: "allow: GET,HEAD,POST,OPTIONS,PUT"
                 ]
               }
    end

    test "response_for_option/1 should return 200 OK for '/method_options'" do
      response = MethodOptionsController.response_for_option()

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0",
                   allow: "allow: GET,HEAD,POST,OPTIONS,PUT"
                 ]
               }
    end
  end
end
