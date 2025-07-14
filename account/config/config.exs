import Config

config :account, AccountWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AccountWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Account.PubSub,
  live_view: [signing_salt: "9NzuPgxk"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
