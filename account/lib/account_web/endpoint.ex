defmodule AccountWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :account

  @session_options [
    store: :cookie,
    key: "_account_key",
    signing_salt: "9NzuPgxk"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :account,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt),
    headers: %{"Access-Control-Allow-Origin" => "*", "Access-Control-Allow-Headers" => "*"}

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug AccountWeb.Router
end
