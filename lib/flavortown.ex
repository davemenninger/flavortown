defmodule Flavortown do
  @moduledoc """
  Flavortown keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def receive(%{url: url, ref: ref}) do
    case ref do
      "refs/heads/master" ->
        case Flavortown.lookup_url(url) do
          {:ok, _flavor} -> IO.puts("alright, we know how to deploy this")
          {:error, _} -> IO.puts("bad url")
        end

      _ ->
        IO.puts("bad ref")
    end
  end

  def lookup_url(url) do
    case url do
      "https://github.com/davemenninger/flavortown" ->
        {:ok, "herp"}

      _ ->
        {:error, "derp"}
    end
  end
end
