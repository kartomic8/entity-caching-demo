defmodule Marketplace.DataStore do
  @moduledoc """
  Hardcoded data store for marketplace event cards.
  """

  @event_cards [
    %{
      home_participant: %{resource_uri: "/teams/1", __typename: "Team"},
      away_participant: %{resource_uri: "/teams/2", __typename: "Team"}
    },
    %{
      home_participant: %{resource_uri: "/teams/3", __typename: "Team"},
      away_participant: %{resource_uri: "/teams/4", __typename: "Team"}
    },
    %{
      home_participant: %{resource_uri: "/teams/5", __typename: "Team"},
      away_participant: %{resource_uri: "/teams/6", __typename: "Team"}
    },
    %{
      home_participant: %{resource_uri: "/players/1", __typename: "Player"},
      away_participant: %{resource_uri: "/players/2", __typename: "Player"}
    },
    %{
      home_participant: %{resource_uri: "/players/3", __typename: "Player"},
      away_participant: %{resource_uri: "/players/4", __typename: "Player"}
    },
    %{
      home_participant: %{resource_uri: "/players/5", __typename: "Player"},
      away_participant: %{resource_uri: "/players/6", __typename: "Player"}
    }
  ]

  def get_upcoming_events do
    @event_cards
  end
end
