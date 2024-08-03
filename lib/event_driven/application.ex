defmodule EventDriven.Application do
  @moduledoc false

  use Commanded.Application, otp_app: :command_center

  router(EventDriven.Router)
end
