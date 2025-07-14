defmodule MarketplaceWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    forward "/graphql", Absinthe.Plug,
      schema: MarketplaceWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send} 

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: MarketplaceWeb.Schema,
      interface: :simple
  end
   
  scope "/", MarketplaceWeb do
    pipe_through :api
  end

  def absinthe_before_send(conn, _blueprint) do
    conn = Plug.Conn.delete_resp_header(conn, "cache-control")
    case Marketplace.CacheHeaderValue.get() do
      nil -> conn 
      "" -> conn
      header -> Plug.Conn.put_resp_header(conn, "cache-control", header) 
    end
  end
end
