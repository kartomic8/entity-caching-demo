defmodule HeadshotsWeb.Resolvers.CacheHeader do
  @moduledoc """
  Resolver for managing cache headers in the headshots subgraph.
  """

  def update_cache_header(_, %{header: header}, _) when is_nil(header) or header == "" do
    # Clear cache header
    Headshots.CacheHeaderValue.clear()
    {:ok, :ok}
  end

  def update_cache_header(_, %{header: header}, _) do
    # Set cache header
    Headshots.CacheHeaderValue.set(header)
    {:ok, :ok}
  end

  def update_cache_header(_, _, _) do
    # No header provided, clear it
    Headshots.CacheHeaderValue.clear()
    {:ok, :ok}
  end
end
