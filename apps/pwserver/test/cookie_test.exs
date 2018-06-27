defmodule CookieTests do
  use ExUnit.Case

  describe "Cookie unit tests" do
    test "response_for_get/1 should return 200 OK status" do
      response = Cookiecontroller.response_for_get()
      assert response ==
               %{
                 body: "<html><head></head><body>Eat</body></html>",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 42"
                 ]
               }
    end

    test "create_response/1 should return 200 OK for 'GET'" do
      request_map = %{
        path: "/form",
        request_type: "GET",
        querystring: [
          type: "chocolate"
        ]
      }
      response = Cookiecontroller.create_response(request_map)

      assert response ==
               %{
                 body: "<html><head></head><body>Eat</body></html>",
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 42"
                 ]
               }
    end
  end
end