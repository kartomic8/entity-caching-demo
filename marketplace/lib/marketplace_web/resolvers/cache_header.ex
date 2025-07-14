defmodule MarketplaceWeb.Resolvers.CacheHeader do
  @moduledoc """
  Resolver for managing cache headers in the marketplace subgraph.
  """

  def update_cache_header(_, %{header: header}, _) when is_nil(header) or header == "" do
    # Clear cache header
    Process.put(:cache_header, nil)
    {:ok, :ok}
  end

  def update_cache_header(_, %{header: header}, _) do
    # Set cache header
    Process.put(:cache_header, header)
    {:ok, :ok}
  end

  def update_cache_header(_, _, _) do
    # No header provided, clear it
    Process.put(:cache_header, nil)
    {:ok, :ok}
  end
end
