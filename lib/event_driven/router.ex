defmodule EventDriven.Router do
  @moduledoc false
  use Commanded.Commands.Router

  alias EventDriven.Commands.AddPackToInventory

  alias EventDriven.{
    TicketPack,
    TicketPackCommandHandler
  }

  dispatch(AddPackToInventory,
    to: TicketPackCommandHandler,
    aggregate: TicketPack,
    identity: :pack_number
  )
end
