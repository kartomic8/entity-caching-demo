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
      schema: AccountWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: AccountWeb.Schema,
      interface: :simple
  end
   
  # scope "/", AccountWeb do
    # pipe_through :api
  # end
end
