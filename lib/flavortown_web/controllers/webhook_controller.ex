defmodule FlavortownWeb.WebhookController do
  use FlavortownWeb, :controller

  def receive(conn, _params) do
    IO.inspect(_params)

    conn
    |> put_status(:accepted)
    |> json(%{})
  end
end
