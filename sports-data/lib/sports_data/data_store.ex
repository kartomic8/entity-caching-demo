defmodule SportsData.Player do
  defstruct [:resource_uri, :full_name, :short_name]
end

defmodule SportsData.Team do
  defstruct [:resource_uri, :full_name, :abbreviation]
end

defmodule SportsData.DataStore do
  @moduledoc """
  Hardcoded data store for sports data entities.
  """

  @players %{
    "/players/1" => %SportsData.Player{
      resource_uri: "/players/1",
      full_name: "LeBron James",
      short_name: "L. James"
    },
    "/players/2" => %SportsData.Player{
      resource_uri: "/players/2",
      full_name: "Stephen Curry",
      short_name: "S. Curry"
    },
    "/players/3" => %SportsData.Player{
      resource_uri: "/players/3",
      full_name: "Kevin Durant",
      short_name: "K. Durant"
    },
    "/players/4" => %SportsData.Player{
      resource_uri: "/players/4",
      full_name: "Giannis Antetokounmpo",
      short_name: "G. Antetokounmpo"
    },
    "/players/5" => %SportsData.Player{
      resource_uri: "/players/5",
      full_name: "Luka Doncic",
      short_name: "L. Doncic"
    },
    "/players/6" => %SportsData.Player{
      resource_uri: "/players/6",
      full_name: "Jayson Tatum",
      short_name: "J. Tatum"
    }
  }

  @teams %{
    "/teams/1" => %SportsData.Team{
      resource_uri: "/teams/1",
      full_name: "Los Angeles Lakers",
      abbreviation: "LAL"
    },
    "/teams/2" => %SportsData.Team{
      resource_uri: "/teams/2",
      full_name: "Golden State Warriors",
      abbreviation: "GSW"
    },
    "/teams/3" => %SportsData.Team{
      resource_uri: "/teams/3",
      full_name: "Brooklyn Nets",
      abbreviation: "BKN"
    },
    "/teams/4" => %SportsData.Team{
      resource_uri: "/teams/4",
      full_name: "Milwaukee Bucks",
      abbreviation: "MIL"
    },
    "/teams/5" => %SportsData.Team{
      resource_uri: "/teams/5",
      full_name: "Dallas Mavericks",
      abbreviation: "DAL"
    },
    "/teams/6" => %SportsData.Team{
      resource_uri: "/teams/6",
      full_name: "Boston Celtics",
      abbreviation: "BOS"
    }
  }

  def get_player(resource_uri) do
    Map.get(@players, resource_uri)
  end

  def get_team(resource_uri) do
    Map.get(@teams, resource_uri)
  end

  def all_players do
    Map.values(@players)
  end

  def all_teams do
    Map.values(@teams)
  end
end
