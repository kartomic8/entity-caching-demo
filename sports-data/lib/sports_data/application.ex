defmodule SportsData.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SportsDataWeb.Telemetry,
      {Phoenix.PubSub, name: SportsData.PubSub},
      SportsDataWeb.Endpoint,
      {SportsData.CacheHeaderValue, "private, max-age=0, must-revalidate"}
    ]

    opts = [strategy: :one_for_one, name: SportsData.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    SportsDataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
