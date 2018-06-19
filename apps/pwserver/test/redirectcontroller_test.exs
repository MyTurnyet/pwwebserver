defmodule RedirectControllerTest do
  use ExUnit.Case
  require RedirectController

  describe "Redirect Controller Unit Tests" do
    test "create_response/1 should return 200 OK for 'GET'" do
      response = RedirectController.create_response("GET")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 302",
                   location: "location: /",
                   content_length: "content-length: 0"
                 ]
               }
    end
  end
end
