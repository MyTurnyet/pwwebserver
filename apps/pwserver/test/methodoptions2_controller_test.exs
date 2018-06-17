defmodule MethodOptions2ControllerTest do
  use ExUnit.Case
  require MethodOptions2Controller

  describe "MethodOptions2Controller Unit Tests" do
    test "response_for_option/1 should return 200 OK for '/method_options2'" do
      response = MethodOptions2Controller.response_for_option()

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0",
                   allow: "allow: GET,OPTIONS,HEAD"
                 ]
               }
    end

    test "create_response/1 should return 200 OK for 'OPTIONS'" do
      response = MethodOptions2Controller.create_response("OPTIONS")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0",
                   allow: "allow: GET,OPTIONS,HEAD"
                 ]
               }
    end
  end
end
