defmodule MarketplaceWeb.Resolvers.CacheHeader do
  @moduledoc """
  Resolver for managing cache headers in the marketplace subgraph.
  """

  def update_cache_header(_, %{header: header}, _) when is_nil(header) or header == "" do
    # Clear cache header
    Marketplace.CacheHeaderValue.clear()
    {:ok, :ok}
  end

  def update_cache_header(_, %{header: header}, _) do
    # Set cache header
    Marketplace.CacheHeaderValue.set(header)
    {:ok, :ok}
  end

  def update_cache_header(_, _, _) do
    # No header provided, clear it
    Marketplace.CacheHeaderValue.clear()
    {:ok, :ok}
  end
end
