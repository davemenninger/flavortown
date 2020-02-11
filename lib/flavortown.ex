defmodule Flavortown do
  @moduledoc """
  Flavortown keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  # TODO: you'd actually get this from the db
  @my_apps %{
    %{url: "https://github.com/davemenninger/flavortown", ref: "refs/heads/master"} => Flavortown.Flavors.Default
  }

  def receive(%{url: _url, ref: _ref} = update) do
    update
    |> Flavortown.lookup()
    |> Flavortown.enqueue_update()
  end

  def lookup(%{url: _url, ref: _ref} = update) do
    update
    |> Map.put(:flavor, @my_apps[update])
  end

  def enqueue_update(%{ref: _ref, url: _url, flavor: _flavor} = update) do
    Flavortown.DeployQueue.enqueue(update)
  end
end
