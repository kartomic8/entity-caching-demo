defmodule AccountWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
    plug AccountWeb.Plugs.UserHeader
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: AccountWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send}

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: AccountWeb.Schema,
      interface: :simple
  end
  
  def absinthe_before_send(conn, _blueprint) do
    conn = Plug.Conn.delete_resp_header(conn, "cache-control")
    case Account.CacheHeaderValue.get() do
      nil -> conn 
      "" -> conn
      header -> Plug.Conn.put_resp_header(conn, "cache-control", header) 
    end
  end
end
