import Config

config :sports_data, SportsDataWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SportsDataWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SportsData.PubSub,
  live_view: [signing_salt: "8NyuPfxj"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
