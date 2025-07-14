defmodule Marketplace.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MarketplaceWeb.Telemetry,
      {Phoenix.PubSub, name: Marketplace.PubSub},
      MarketplaceWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Marketplace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MarketplaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
