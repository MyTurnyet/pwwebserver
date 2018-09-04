defmodule DataStateTests do
  use ExUnit.Case
  require Logger

  describe "DataState unit tests" do
    setup do
      {state, _} = DataState.new()
      Logger.debug("Current data state: #{state}")
    end

    test "post/2 should set data" do
      DataState.post("foobar")
      data = DataState.get()
      assert data == "foobar"
    end

    test "delete/2 deletes the existing data" do
      DataState.post("foobar")
      data = DataState.delete()
      assert data == :ok
    end
  end
end
