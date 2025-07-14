import Config

config :account, AccountWeb.Endpoint,
  http: [port: 4000],
  url: [host: "localhost", port: 4000],
  server: true

config :logger, level: :info
