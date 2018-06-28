defmodule DataStateTests do
  use ExUnit.Case

  describe "DataState unit tests" do

    test "new/1 should initialize data" do
      {:ok,data_state} = DataState.new
      data = DataState.get(data_state)
      assert data == ""
    end

    test "post/2 should set data" do
      {:ok,data_state} = DataState.new
      DataState.post(data_state, "foobar")
      data = DataState.get(data_state)
      assert data == "foobar"
    end

    test "delete/2 deletes the existing data" do
      {:ok,data_state} = DataState.new
      DataState.post(data_state, "foobar")
      data = DataState.delete(data_state)
    assert data == :ok
    end

  end
end