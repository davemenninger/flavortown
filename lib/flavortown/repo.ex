defmodule Flavortown.Repo do
  use Ecto.Repo,
    otp_app: :flavortown,
    adapter: Ecto.Adapters.Postgres
end
