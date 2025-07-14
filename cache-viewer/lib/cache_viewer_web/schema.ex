defmodule CacheViewerWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  
  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7"
  end

  object :cache_entry do
    field(:key, non_null(:string))
    field(:value, :string)
    field(:ttl, :string)
  end

  query(name: "Query") do
    field :get_cache_entries, non_null(list_of(non_null(:cache_entry))) do
      resolve(&CacheViewerWeb.Resolvers.Cache.get_cache_entries/3)
    end
  end

  def context(ctx) do
    loader = Dataloader.new()
    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
