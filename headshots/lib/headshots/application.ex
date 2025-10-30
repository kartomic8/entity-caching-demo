defmodule Headshots.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HeadshotsWeb.Telemetry,
      {Phoenix.PubSub, name: Headshots.PubSub},
      HeadshotsWeb.Endpoint,
      {Headshots.CacheHeaderValue, "private, max-age=0, must-revalidate"}
    ]

    opts = [strategy: :one_for_one, name: Headshots.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    HeadshotsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
