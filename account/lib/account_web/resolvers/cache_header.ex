defmodule AccountWeb.Resolvers.CacheHeader do
  @moduledoc """
  Resolver for managing cache headers in the account subgraph.
  """

  def update_cache_header(_, %{header: header}, _) when is_nil(header) or header == "" do
    # Clear cache header
    Account.CacheHeaderValue.clear()
    {:ok, :ok}
  end

  def update_cache_header(_, %{header: header}, _) do
    # Set cache header
    Account.CacheHeaderValue.set(header)
    {:ok, :ok}
  end

  def update_cache_header(_, _, _) do
    # No header provided, clear it
    Account.CacheHeaderValue.clear()
    {:ok, :ok}
  end
end
