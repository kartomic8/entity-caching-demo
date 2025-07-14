defmodule MarketplaceWeb.Resolvers.Events do
  @moduledoc """
  Resolver for marketplace events.
  """

  def get_upcoming_events(_, _, _) do
    {:ok, Marketplace.DataStore.get_upcoming_events()}
  end
end
