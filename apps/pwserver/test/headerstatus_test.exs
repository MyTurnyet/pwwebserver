defmodule HeaderStatusTests do
  use ExUnit.Case
  require HeaderStatus

  describe "HeaderStatus Unit Tests" do

    test "add_content_length_header/1 should return correct Content Length in header" do
      response_map = %{
        header: [
          status: "http/1.1 200 OK"
        ],
        body: "1234"
      }

      response_map = HeaderStatus.add_content_length_header(response_map)
      assert response_map.header[:content_length] == "content-length: 4"
    end

    test "add_200_ok_status/1 will return 200 OK header" do
      response = HeaderStatus.add_200_ok_status(%{})
      headers = response.header
      assert headers[:status] == "HTTP/1.1 200 OK"
    end

    test "add_201_created_status/1 will return 201 Created header" do
      response = HeaderStatus.add_201_created_status(%{}, "/cat-form/data")
      assert response == %{
               header: [
                 status: "HTTP/1.1 201 Created",
                 location: "location: /cat-form/data"
               ]
             }
    end
    test "add_302_found_status/2 will return 302 Found and location" do
      assert HeaderStatus.add_302_found_status(%{}, "/") == %{
               header: [
                 status: "HTTP/1.1 302",
                 location: "location: /"
               ]
             }
    end

    test "add_401_authenticate/1 will return HTTP 401 Unauthorized status" do
      assert HeaderStatus.add_401_authenticate_status(%{}) == %{
               header: [
                 status: "HTTP/1.1 401 Unauthorized",
                 www_authenticate: "WWW-Authenticate: Basic realm=\"User Visible Realm\"",
               ]
             }
    end
    test "add_404_not_found_status/1 will return 404 Not Found" do
      assert HeaderStatus.add_404_not_found_status(%{}) == %{
               header: [
                 status: "HTTP/1.1 404 Not Found",
               ]
             }
    end

    test "add_418_im_a_teapot_status/1 will return 418 I'm a teapot" do
      assert HeaderStatus.add_418_im_a_teapot_status(%{}) == %{
               header: [
                 status: "HTTP/1.1 418 I'm a teapot"
               ]
             }
    end

    test "add_418_status_body/1 will return I'm a teapot for the body" do
      assert HeaderStatus.add_418_status_body(
               %{
                 header: [
                   status: "HTTP/1.1 418 I'm a teapot"
                 ]
               }
             ) ==
               %{
                 header: [
                   status: "HTTP/1.1 418 I'm a teapot",
                   content_length: "content-length: 51"
                 ],
                 body: "<html><head></head><body>I'm a teapot</body></html>"
               }
    end



  end
end
