defmodule Account.Team do
  defstruct [:resource_uri, :is_favorite]
end

defmodule Account.Player do
  defstruct [:resource_uri, :is_favorite]
end

defmodule Account.DataStore do
  @moduledoc """
  Hardcoded data store for account entities.
  """

  @users %{
    "user_1" => %{
      id: "user_1",
      nickname: "SportsFan1"
    },
    "user_2" => %{
      id: "user_2",
      nickname: "BasketballLover"
    }
  }

  # Hardcoded favorite data for users
  @user_favorites %{
    "user_1" => %{
      teams: ["/teams/1", "/teams/2"],
      players: ["/players/1", "/players/2"]
    },
    "user_2" => %{
      teams: ["/teams/3", "/teams/4"],
      players: ["/players/3", "/players/4", "/players/5"]
    }
  }

  def get_user(user_id) do
    Map.get(@users, user_id)
  end

  def is_team_favorite(user_id, resource_uri) do
    case get_user_favorites(user_id) do
      nil -> false
      favorites -> Enum.member?(favorites.teams, resource_uri)
    end
  end

  def is_player_favorite(user_id, resource_uri) do
    case get_user_favorites(user_id) do
      nil -> false
      favorites -> Enum.member?(favorites.players, resource_uri)
    end
  end

  defp get_user_favorites(user_id) do
    Map.get(@user_favorites, user_id)
  end

  def all_users do
    Map.values(@users)
  end
end
