defmodule SportsData.CacheHeaderValue do
  use Agent

  def start_link(initial_value) do
     Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get do
     Agent.get(__MODULE__, & &1)
  end

  def set(value) do
     Agent.update(__MODULE__, fn _ -> value end)
  end

  def clear do
     Agent.update(__MODULE__, fn _ -> nil end)
  end 
end
