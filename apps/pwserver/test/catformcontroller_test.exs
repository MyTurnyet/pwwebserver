defmodule CatFormControllerTests do
  use ExUnit.Case
  require HeaderStatus
  
  describe "CatForm Controller unit tests" do

    test "response_for_get/0 shoulde return 404 Not Found when no data set" do
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

#    test "response_for_get/0 should return 200 Ok and correct data" do
#      response = CatFormController.response_for_get()
#
#      assert response == %{
#               body: "data=fatcat",
#               header: [
#                 status: "HTTP/1.1 200 Ok",
#                 content_length: "content-length: 11"
#               ]
#             }
#    end
  end
end