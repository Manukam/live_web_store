defmodule LiveWebStore.Repo do
  use Ecto.Repo,
    otp_app: :live_web_store,
    adapter: Ecto.Adapters.Postgres
end
