defmodule EventDriven.Events.TicketPackAdded do
  @derive Jason.Encoder
  defstruct [:game_id, :pack_number, :location_id, :added_at]
end
