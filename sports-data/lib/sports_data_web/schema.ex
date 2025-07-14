defmodule SportsDataWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: ["@key"]
  end

  enum :result, values: [:ok, :error]

  object :player do
    key_fields("resourceUri")
    field(:resource_uri, non_null(:string))
    field(:full_name, non_null(:string))
    field(:short_name, non_null(:string))
    
    field :_resolve_reference, :player, resolve: (fn %{resource_uri: resource_uri}, _ ->
      case SportsData.DataStore.get_player(resource_uri) do
        nil -> {:error, "Player not found"}
        player -> {:ok, player}
      end
    end)
  end

  object :team do
    key_fields("resourceUri")
    field(:resource_uri, non_null(:string))
    field(:full_name, non_null(:string))
    field(:abbreviation, non_null(:string))
    
    field :_resolve_reference, :team, resolve: (fn %{resource_uri: resource_uri}, _ ->
      case SportsData.DataStore.get_team(resource_uri) do
        nil -> {:error, "Team not found"}
        team -> {:ok, team}
      end
    end)
  end

  query(name: "Query") do
  
  end

  mutation(name: "Mutation") do
    field :update_sports_data_cache_header, :result do
      arg(:header, :string)
      resolve(&SportsDataWeb.Resolvers.CacheHeader.update_cache_header/3)
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
    middleware ++ [SportsDataWeb.Middleware.CacheHeader]
  end
end
