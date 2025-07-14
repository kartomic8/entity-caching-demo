import Config

config :cache_viewer, CacheViewerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CacheViewerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CacheViewer.PubSub,
  live_view: [signing_salt: "0OzuPgxl"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
