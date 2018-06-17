defmodule OptionsControllerTest do
  use ExUnit.Case
  require OptionsController

  describe "OptionController Unit Tests" do
    test "response_for_option/1 should return 200 OK for '/method_options'" do
      response = OptionsController.response_for_option("/method_options")

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

    test "response_for_option/1 should return 200 OK for '/method_options2'" do
      response = OptionsController.response_for_option("/method_options2")

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
