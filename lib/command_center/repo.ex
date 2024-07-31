defmodule CommandCenter.Repo do
  use Ecto.Repo,
    otp_app: :command_center,
    adapter: Ecto.Adapters.Postgres
end
