import Config

config :headshots, HeadshotsWeb.Endpoint,
  url: [host: "localhost"],
  pubsub_server: Headshots.PubSub,
  live_view: [signing_salt: "HeadSh0t"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
