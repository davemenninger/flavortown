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
          {:ok, flavor} -> Flavortown.enqueue_stack_update(ref: ref, url: url, flavor: flavor)
          {:error, _} -> IO.puts("bad url")
        end

      _ ->
        IO.puts("bad ref")
    end
  end

  def lookup_url(url) do
    case url do
      "https://github.com/davemenninger/flavortown" -> {:ok, :default}
      _ -> {:error, :unknown}
    end
  end

  def enqueue_stack_update(ref: ref, url: url, flavor: flavor) do
    case flavor do
      :default -> IO.puts(Flavortown.Flavors.Default.generate_stack(ref: ref, url: url)) # hand this stack definition over to a deploying queue
      _ -> {:error, "unknown flavor"}
    end
  end
end
