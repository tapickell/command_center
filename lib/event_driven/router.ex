defmodule EventDriven.Router do
  @moduledoc false
  use Commanded.Commands.Router

  alias EventDriven.{
    Commands.AddPackToInventory,
    TicketPack,
    TicketPackHandler
  }

  dispatch(AddPackToInventory,
    to: TicketPackHandler,
    aggregate: TicketPack,
    identity: :pack_number
  )
end
