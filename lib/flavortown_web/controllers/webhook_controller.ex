defmodule FlavortownWeb.WebhookController do
  use FlavortownWeb, :controller

  def receive(
        conn,
        %{
          "repository" => %{"url" => url},
          "ref" => ref
        } = _params
      ) do
    # url + ref = our lookup key to see if we know what to do with event
    Flavortown.receive(%{url: url, ref: ref})

    conn
    |> put_status(:accepted)
    |> json(%{})
  end
end
