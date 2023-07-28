defmodule Clarx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ClarxWeb.Telemetry,
      # Start the Ecto repository
      Clarx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Clarx.PubSub},
      # Start Finch
      {Finch, name: Clarx.Finch},
      # Start the Endpoint (http/https)
      ClarxWeb.Endpoint
      # Start a worker by calling: Clarx.Worker.start_link(arg)
      # {Clarx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Clarx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClarxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
