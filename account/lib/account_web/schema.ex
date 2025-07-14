defmodule AccountWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: ["@key"]
  end

  enum :result, values: [:ok, :error]

  object :user do
    key_fields("id")
    field(:id, non_null(:id))
    field(:nickname, non_null(:string))
    
    field :_resolve_reference, :user, resolve: fn %{id: id}, _, _ ->
      case Account.DataStore.get_user(id) do
        nil -> {:error, "User not found"}
        user -> {:ok, user}
      end
    end
  end

  object :team do
    key_fields("resourceUri")
    field(:resource_uri, non_null(:string))
    field(:is_favorite, :boolean) do
      resolve(fn %{resource_uri: resource_uri}, _, %{context: %{user_id: user_id}} ->
        case user_id do
          nil -> {:ok, nil}
          _ -> {:ok, Account.DataStore.is_team_favorite(user_id, resource_uri)}
        end
      end)
    end
    
    field :_resolve_reference, :team, resolve: (fn %{resource_uri: resource_uri}, _, %{context: %{user_id: user_id}} ->
      {:ok, %{resource_uri: resource_uri, is_favorite: Account.DataStore.is_team_favorite(user_id, resource_uri)}}
    end)
  end

  object :player do
    key_fields("resourceUri")
    field(:resource_uri, non_null(:string))
    field(:is_favorite, :boolean) do
      resolve(fn %{resource_uri: resource_uri}, _, %{context: %{user_id: user_id}} ->
        case user_id do
          nil -> {:ok, nil}
          _ -> {:ok, Account.DataStore.is_player_favorite(user_id, resource_uri)}
        end
      end)
    end
    
    field :_resolve_reference, :player, resolve: (fn %{resource_uri: resource_uri}, _, %{context: %{user_id: user_id}} ->
      {:ok, %{resource_uri: resource_uri, is_favorite: Account.DataStore.is_player_favorite(user_id, resource_uri)}}
    end)
  end

  query(name: "Query") do
  
  end

  mutation do
    field :update_account_cache_header, :result do
      arg(:header, :string)
      resolve(&AccountWeb.Resolvers.CacheHeader.update_cache_header/3)
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
    middleware ++ [AccountWeb.Middleware.CacheHeader]
  end
end
