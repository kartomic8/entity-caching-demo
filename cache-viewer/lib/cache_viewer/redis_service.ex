defmodule CacheViewer.RedisService do
  @moduledoc """
  Service for interacting with Redis cache.
  """

  def get_cache_entries do
    case Redix.command(:redix, ["KEYS", "*"]) do
      {:ok, keys} ->
        entries = 
          keys
          |> Enum.map(&get_cache_entry/1)
          |> Enum.filter(& &1)

        {:ok, entries}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp get_cache_entry(key) do
    case Redix.command(:redix, ["GET", key]) do
      {:ok, value} ->
        ttl = case Redix.command(:redix, ["TTL", key]) do
          {:ok, -1} -> "No expiry"
          {:ok, -2} -> "Expired"
          {:ok, seconds} -> "#{seconds} seconds"
          _ -> "Unknown"
        end

        %{
          key: key,
          value: value,
          ttl: ttl
        }

      {:error, _} ->
        nil
    end
  end
end
