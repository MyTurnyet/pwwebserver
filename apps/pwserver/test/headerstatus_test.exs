defmodule HeaderStatus_Tests do
  use ExUnit.Case
require HeaderStatus

describe "HEaderStatus Unit Tests" do


  test "add_200_ok_status/1 will return 200 OK header" do
      response = HeaderStatus.add_200_ok_status(%{})
      headers = response.header
      assert headers[:status] == "HTTP/1.1 200 OK"
    end

    test "add_404_not_found_status/1 will return 404 Not Found" do
      assert HeaderStatus.add_404_not_found_status(%{}) == %{header: [status: "HTTP/1.1 404 Not Found"], body: ""}
    end

    test "add_418_im_a_teapot_status/1 will return 418 I'm a teapot" do
      assert HeaderStatus.add_418_im_a_teapot_status(%{}) == %{header: [status: "HTTP/1.1 418 I'm a teapot"]}
    end

    test "add_418_status_body/1 will return I'm a teapot for the body" do
      assert HeaderStatus.add_418_status_body(%{header: [status: "HTTP/1.1 418 I'm a teapot"]}) ==
        %{header: [status: "HTTP/1.1 418 I'm a teapot", content_length: "content-length: 12"], body: "I'm a teapot"}
    end

  end
end