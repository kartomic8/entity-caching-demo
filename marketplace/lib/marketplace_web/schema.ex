defmodule MarketplaceWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: ["@key"]
  end

  enum :result, values: [:ok, :error]

  object :player do
    directive :key, fields: "resourceUri", resolvable: false
    field(:resource_uri, non_null(:string))
  end

  object :team do
    directive :key, fields: "resourceUri", resolvable: false
    field(:resource_uri, non_null(:string))
  end

  union :participant do
    types([:team, :player])
    resolve_type(fn
      %{__typename: "Team"}, _ -> :team
      %{__typename: "Player"}, _ -> :player
      _, _ -> nil
    end)
  end

  object :event_card do
    field(:home_participant, :participant)
    field(:away_participant, :participant)
  end

  query(name: "Query") do
    field :upcoming_events, non_null(list_of(non_null(:event_card))) do
      resolve(&MarketplaceWeb.Resolvers.Events.get_upcoming_events/3)
    end
  end

  mutation(name: "Mutation") do
    field :update_marketplace_cache_header, :result do
      arg(:header, :string)
      resolve(&MarketplaceWeb.Resolvers.CacheHeader.update_cache_header/3)
    end
  end

  def context(ctx) do
    loader = Dataloader.new()
    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    middleware ++ [MarketplaceWeb.Middleware.CacheHeader]
  end
end
