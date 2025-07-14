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
      context: %{pubsub: Marketplace.PubSub}

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: MarketplaceWeb.Schema,
      interface: :simple,
      context: %{pubsub: Marketplace.PubSub}
  end
   
  scope "/", MarketplaceWeb do
    pipe_through :api
  end
end
