import Config

config :marketplace, MarketplaceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MarketplaceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Marketplace.PubSub,
  live_view: [signing_salt: "1PzuPgxm"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
