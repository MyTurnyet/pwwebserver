defmodule CatFormControllerTests do
  use ExUnit.Case
  require HeaderStatus
  alias State.DataState

  describe "CatForm Controller unit tests" do
    test "response_for_get/0 shoulde return 404 Not Found when no data set" do
      DataState.new()
      DataState.post("")
      response = CatFormController.response_for_get()

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 404 Not Found",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "response_for_post/0 should return 201 for 'POST'" do
      DataState.new()
      response = CatFormController.response_for_post("data=return20")

      assert response ==
               %{
                 body: "",
                 header: [
                   status: "HTTP/1.1 201 Created",
                   location: "location: /cat-form/data",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "response_for_get/0 should return 200 Ok and correct data" do
      DataState.new()
      DataState.post("return200GACK")
      response = CatFormController.response_for_get()

      assert response == %{
               body: "<html><head></head><body>data=return200GACK</body></html>",
               header: [
                 status: "HTTP/1.1 200 OK",
                 content_length: "content-length: 57"
               ]
             }
    end
  end
end
