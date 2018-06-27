defmodule LogsControllerTest do
  use ExUnit.Case

  def body_text() do
    ""
  end

  def body_with_logs() do
    "<html><head></head><body>GET /log HTTP/1.1<br/>PUT /these HTTP/1.1<br/>HEAD /requests HTTP/1.1<br/></body></html>"
  end

  describe "Logs Controller Unit Tests" do
    test "unauthenticated_response_for_get/0 should return 401 Unathorized when unauthenticated" do
      response = LogsController.unauthenticated_response_for_get()

      assert response ==
               %{
                 body: body_text(),
                 header: [
                   status: "HTTP/1.1 401 Unauthorized",
                   www_authenticate: "WWW-Authenticate: Basic realm=\"User Visible Realm\"",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "authenticated_response_for_get/0 should return 200 OK when authenticated" do
      response = LogsController.authenticated_response_for_get()

      assert response ==
               %{
                 body: body_with_logs(),
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 113"
                 ]
               }
    end

    test "create_response/1 should return 401 Unauthorized when unauthenticated" do
      request_map = %{path: "/logs", request_type: "GET", headers: %{}}

      response = LogsController.create_response(request_map)

      assert response ==
               %{
                 body: body_text(),
                 header: [
                   status: "HTTP/1.1 401 Unauthorized",
                   www_authenticate: "WWW-Authenticate: Basic realm=\"User Visible Realm\"",
                   content_length: "content-length: 0"
                 ]
               }
    end

    test "create_response/1 should return 200 OK when authenticated" do
      request_map = %{
        path: "/logs",
        request_type: "GET",
        headers: %{
          Authorization: "Basic YWRtaW46aHVudGVyMg=="
        }
      }

      response = LogsController.create_response(request_map)

      assert response ==
               %{
                 body: body_with_logs(),
                 header: [
                   status: "HTTP/1.1 200 OK",
                   content_length: "content-length: 113"
                 ]
               }
    end

    test "request_is_authorized/1 should return false" do
      request_map = %{
        path: "/logs",
        request_type: "GET",
        headers: %{}
      }

      response = LogsController.request_is_authorized(request_map)
      assert response == false
    end

    test "request_is_authorized/1 should return true" do
      request_map = %{
        path: "/logs",
        request_type: "GET",
        headers: %{
          Authorization: "Basic YWRtaW46aHVudGVyMg=="
        }
      }

      assert LogsController.request_is_authorized(request_map) == true
    end

  end
end
