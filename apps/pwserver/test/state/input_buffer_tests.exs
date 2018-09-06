defmodule InputBufferTests do
  use ExUnit.Case
  alias State.InputBuffer

  describe "InputBuffer unit tests" do
    test "create/0 should return a pid" do
      assert {:ok, buffer_pid} = InputBuffer.create()
    end

  end
end
