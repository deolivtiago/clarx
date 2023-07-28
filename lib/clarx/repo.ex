defmodule Clarx.Repo do
  use Ecto.Repo,
    otp_app: :clarx,
    adapter: Ecto.Adapters.Postgres
end
