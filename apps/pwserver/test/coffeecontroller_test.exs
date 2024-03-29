defmodule CoffeeControllerTest do
  use ExUnit.Case
  require TeaController

  describe "CoffeeController Unit Tests" do
    test "response_for_get/0 should return 400 Bad Request for '/coffee'" do
      response = CoffeeController.response_for_get()

      assert response ==
               %{
                 body: "<html><head></head><body>I'm a teapot</body></html>",
                 header: [
                   status: "HTTP/1.1 418 I'm a teapot",
                   content_length: "content-length: 51"
                 ]
               }
    end
  end
end
