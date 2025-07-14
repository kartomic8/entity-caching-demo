defmodule CacheViewer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CacheViewerWeb.Telemetry,
      {Phoenix.PubSub, name: CacheViewer.PubSub},
      {Redix, name: :redix, host: redis_host(), port: redis_port()},
      CacheViewerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: CacheViewer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    CacheViewerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp redis_host do
    case System.get_env("REDIS_URL") do
      nil -> "localhost"
      url ->
        uri = URI.parse(url)
        uri.host || "localhost"
    end
  end

  defp redis_port do
    case System.get_env("REDIS_URL") do
      nil -> 6380
      url ->
        uri = URI.parse(url)
        uri.port || 6380
    end
  end
end
