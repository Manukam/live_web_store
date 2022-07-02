defmodule LiveWebStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LiveWebStore.Repo,
      # Start the Telemetry supervisor
      LiveWebStoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveWebStore.PubSub},
      # Start the Endpoint (http/https)
      LiveWebStoreWeb.Endpoint
      # Start a worker by calling: LiveWebStore.Worker.start_link(arg)
      # {LiveWebStore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveWebStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveWebStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
