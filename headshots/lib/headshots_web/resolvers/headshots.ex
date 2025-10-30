defmodule HeadshotsWeb.Resolvers.Headshots do
  @moduledoc """
  Resolvers for headshot URL generation.
  """

  def get_headshot_url(parent, %{size: size}, _resolution) do
    resource_uri = Map.get(parent, :resource_uri)
    
    case extract_player_id(resource_uri) do
      {:ok, player_id} ->
        size_str = size |> Atom.to_string() |> String.downcase()
        url = "https://headshots.example.com/#{player_id}/#{size_str}"
        {:ok, url}
      
      {:error, _reason} ->
        {:error, "Invalid resource URI"}
    end
  end

  defp extract_player_id(resource_uri) when is_binary(resource_uri) do
    case String.split(resource_uri, "/") do
      ["", "players", player_id] -> {:ok, player_id}
      _ -> {:error, :invalid_format}
    end
  end

  defp extract_player_id(_), do: {:error, :invalid_format}
end
