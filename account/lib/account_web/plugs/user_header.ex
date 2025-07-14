defmodule AccountWeb.Plugs.UserHeader do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_req_header(conn, "x-user-id") |> List.first()
    context = %{user_id: user_id}
    Absinthe.Plug.put_options(conn, context: context)
  end
end
