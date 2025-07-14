defmodule CacheViewerWeb.Resolvers.Cache do
  @moduledoc """
  Resolver for cache operations.
  """

  def get_cache_entries(_, _, _) do
    CacheViewer.RedisService.get_cache_entries()
  end
end
