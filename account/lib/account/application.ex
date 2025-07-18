defmodule Account.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AccountWeb.Telemetry,
      {Phoenix.PubSub, name: Account.PubSub},
      AccountWeb.Endpoint,
      {Account.CacheHeaderValue, "private, max-age=0, must-revalidate, foo"}
    ]

    opts = [strategy: :one_for_one, name: Account.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    AccountWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
