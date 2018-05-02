defmodule PW.Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Task.Supervisor, name: PW.Server.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> PW.Server.listen() end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: PW.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
