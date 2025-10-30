defmodule HeadshotsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: ["@key"]
  end

  enum :result, values: [:ok, :error]

  enum :size do
    value :small
    value :medium
    value :large
  end

  object :player do
    key_fields("resourceUri")
    field(:resource_uri, non_null(:string))

    field :headshot_url, :string do
      arg(:size, non_null(:size))
      resolve(&HeadshotsWeb.Resolvers.Headshots.get_headshot_url/3)
    end
    
    field :_resolve_reference, :player, resolve: (fn parent, _ ->
      resource_uri = parent[:resource_uri] || parent["resource_uri"] || parent["resourceUri"]
      {:ok, %{resource_uri: resource_uri}}
    end)
  end

  query(name: "Query") do
  end

  mutation(name: "Mutation") do
    field :update_headshots_cache_header, :result do
      arg(:header, :string)
      resolve(&HeadshotsWeb.Resolvers.CacheHeader.update_cache_header/3)
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
    middleware ++ [HeadshotsWeb.Middleware.CacheHeader]
  end

  def hydrate(%Absinthe.Blueprint.Schema.UnionTypeDefinition{identifier: :_entity}, _) do
    {:resolve_type, &__MODULE__.resolve_entity_type/2}
  end

  def hydrate(_node, _ancestors), do: []

  def resolve_entity_type(%{resource_uri: _}, _), do: :player
  def resolve_entity_type(_, _), do: nil
end
