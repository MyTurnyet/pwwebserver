defmodule PW.ServerTest do
  use ExUnit.Case
  doctest PW.Server

  test "greets the world" do
    assert PW.Server.hello() == :world
  end
end
