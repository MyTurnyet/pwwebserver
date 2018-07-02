defmodule CatFormControllerTests do
  use ExUnit.Case, async: true
  require HeaderStatus
  
  describe "CatForm Controller unit tests" do

    test "response_for_get/0 shoulde return 404 Not Found when no data set" do
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
      response = CatFormController.response_for_post("fatcat")

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

      DataState.post("fatcat")
      response = CatFormController.response_for_get()

      assert response == %{
               body: "<html><head></head><body>data=fatcat</body></html>",
               header: [
                 status: "HTTP/1.1 200 OK",
                 content_length: "content-length: 50"
               ]
             }
    end
  end
end