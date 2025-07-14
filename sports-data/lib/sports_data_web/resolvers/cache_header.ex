defmodule SportsDataWeb.Resolvers.CacheHeader do
  @moduledoc """
  Resolver for managing cache headers in the sports data subgraph.
  """

  def update_cache_header(_, %{header: header}, _) when is_nil(header) or header == "" do
    # Clear cache header
    SportsData.CacheHeaderValue.clear()
    {:ok, :ok}
  end

  def update_cache_header(_, %{header: header}, _) do
    # Set cache header
    SportsData.CacheHeaderValue.set(header)
    {:ok, :ok}
  end

  def update_cache_header(_, _, _) do
    # No header provided, clear it
    SportsData.CacheHeaderValue.clear()
    {:ok, :ok}
  end
end
