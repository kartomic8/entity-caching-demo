defmodule SportsDataWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api
    
    forward "/graphql", Absinthe.Plug,
      schema: SportsDataWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: SportsDataWeb.Schema,
      interface: :simple
  end
end
