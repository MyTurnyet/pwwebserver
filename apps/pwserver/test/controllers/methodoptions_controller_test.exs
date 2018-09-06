defmodule MethodOptionsControllerTest do
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

    test "create_response/1 should return 200 OK for 'GET'" do
      response = MethodOptionsController.create_response("GET")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "create_response/1 should return 200 OK for 'HEAD'" do
      response = MethodOptionsController.create_response("HEAD")

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
      response = MethodOptionsController.create_response("POST")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "create_response/1 should return 200 OK for 'PUT'" do
      response = MethodOptionsController.create_response("PUT")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "response_for_option/0 should return 200 OK for '/method_options'" do
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

    test "response_for_get/0 should return 200 OK for '/method_options'" do
      response = MethodOptionsController.response_for_get()

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
