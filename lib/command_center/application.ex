defmodule CommandCenter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CommandCenterWeb.Telemetry,
      CommandCenter.Repo,
      {DNSCluster, query: Application.get_env(:command_center, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CommandCenter.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CommandCenter.Finch},
      # Start a worker by calling: CommandCenter.Worker.start_link(arg)
      # {CommandCenter.Worker, arg},
      # Start to serve requests, typically the last entry
      CommandCenterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CommandCenter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CommandCenterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
