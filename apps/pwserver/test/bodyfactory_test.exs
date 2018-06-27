defmodule BodyFactoryTests do
  use ExUnit.Case

  describe "BodyFactory unit tests" do
    test "create_empty_body/0 should return zero length body string" do
      response_map = BodyFactory.add_empty_body(%{})
      assert response_map == %{body: ""}
    end
    test "create_body/1 should return correct HTML body string" do
      response_map = BodyFactory.create_body(%{}, "Foo")
      assert response_map == %{body: "<html><head></head><body>Foo</body></html>"}
    end
  end
end