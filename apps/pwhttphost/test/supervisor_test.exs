defmodule PW.Supervisor_Test do
  require Logger
  use ExUnit.Case

  test "Supervisor children should have PW.HttpHost" do
    output = PW.Supervisor.init(:ok)

    assert output =
             {:ok,
              {%{intensity: 3, period: 5, strategy: :one_for_one},
               [
                 %{
                   id: PW.HTTPHost,
                   restart: :permanent,
                   shutdown: 500,
                   start: {PW.HTTPHost, :start_link, [[]]},
                   type: :worker
                 }
               ]}}
  end
end
