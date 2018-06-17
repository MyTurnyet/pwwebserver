defmodule TeaControllerTest do
  use ExUnit.Case
  require TeaController

  describe "TeaController Unit Tests" do
    test "response_for_get/1 should return 200 OK for '/tea'" do
      response = TeaController.response_for_get()

      assert response ==
               %{
                 body: "",
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 0"]
               }
    end
  end
end
