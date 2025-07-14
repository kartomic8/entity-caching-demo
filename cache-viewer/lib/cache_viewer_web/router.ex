defmodule CacheViewerWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    forward "/graphql", Absinthe.Plug,
      schema: CacheViewerWeb.Schema,
      context: %{pubsub: CacheViewer.PubSub}

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CacheViewerWeb.Schema,
      interface: :simple,
      context: %{pubsub: CacheViewer.PubSub}
  end
  
  scope "/", CacheViewerWeb do
    pipe_through :api
  end

end
