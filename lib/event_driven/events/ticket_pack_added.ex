defmodule EventDriven.Events.TicketPackAdded do
  @derive Jason.Encoder
  defstruct [:pack_number, :game_id, :location_id, :first_ticket]
end
