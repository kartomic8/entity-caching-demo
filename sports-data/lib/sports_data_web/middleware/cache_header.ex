defmodule SportsDataWeb.Middleware.CacheHeader do
  @behaviour Absinthe.Middleware

  alias Plug.Conn

  def call(resolution, _config) do
    case Process.get(:cache_header) do
      nil -> resolution
      header -> 
        resolution
        |> put_cache_header(header)
        |> put_context_cache_header(header)
    end
  end

  defp put_cache_header(resolution, header) do
    conn = resolution.context.conn
    new_conn = Conn.put_resp_header(conn, "cache-control", header)
    Map.put(resolution.context, :conn, new_conn)
    resolution
  end
  
  defp put_context_cache_header(resolution, header) do
    context = Map.put(resolution.context, :cache_header, header)
    %{resolution | context: context}
  end
end
