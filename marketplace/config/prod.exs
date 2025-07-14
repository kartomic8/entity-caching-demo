import Config

config :marketplace, MarketplaceWeb.Endpoint,
  http: [port: 4000],
  url: [host: "localhost", port: 4000],
  server: true

config :logger, level: :info
