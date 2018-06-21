defmodule LogsControllerTest do
  use ExUnit.Case

  def body_text do
    ""
  end

  describe "Logs Controller Unit Tests" do
    test "response_for_get/1 should return 401 Unathorized when unauthenticated" do
      response = LogsController.response_for_get()

      assert response ==
               %{
                 body: body_text,
                 header: [
                   status: "HTTP/1.1 401 Unauthorized",
                   www_authenticate: "WWW-Authenticate: Basic realm=\"User Visible Realm\"",
                   content_length: "content-length: 0"
                 ],
                 body: ""
               }
    end
  end
end
