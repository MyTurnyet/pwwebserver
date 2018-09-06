defmodule IndexControllerTest do
  use ExUnit.Case

  def body_text() do
    "<html><head></head><body><a href='/file1'>file1</a><a href='/file2'>file2</a><a href='/image.gif'>image.gif</a><a href='/image.jpeg'>image.jpeg</a><a href='/image.png'>image.png</a><a href='/text-file.txt'>text-file.txt</a></body></html>"

    # "<html><head></head><body><a href=file1></a><a href=file2></a><a href=image.gif></a><a href=image.jpg></a><a href=image.png></a><a href=text-file.txt></a></body></html>"
  end

  describe "Index Controller Unit Tests" do
    test "create_response/1 should return 200 OK for 'GET'" do
      response = IndexController.create_response("GET")

      assert response ==
               %{
                 body: body_text(),
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 237"]
               }
    end

    test "response_for_get/1 should return 200 OK for '/'" do
      response = IndexController.response_for_get()

      assert response ==
               %{
                 body: body_text(),
                 header: [status: "HTTP/1.1 200 OK", content_length: "content-length: 237"]
               }
    end

    test "response_for_head/1 should return 200 OK for '/'" do
      response = IndexController.response_for_head()

      assert response ==
               %{
                 body: body_text(),
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 237"
                 ]
               }
    end
  end
end
