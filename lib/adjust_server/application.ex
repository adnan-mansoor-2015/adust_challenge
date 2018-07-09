defmodule AdjustServer.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      Foo.Repo,
      Bar.Repo,
      # Start the Ecto repository
      supervisor(AdjustServer.Repo, []),
      # Start the endpoint when the application starts
      supervisor(AdjustServerWeb.Endpoint, []),
      # Start your own worker by calling: AdjustServer.Worker.start_link(arg1, arg2, arg3)
      # worker(AdjustServer.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AdjustServer.Supervisor]
    val = Supervisor.start_link(children, opts)
    AdjustServer.perform_migration
    val
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AdjustServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
