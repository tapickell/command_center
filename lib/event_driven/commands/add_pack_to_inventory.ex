defmodule EventDriven.Commands.AddPackToInventory do
  @enforce_keys [:game_id, :pack_number, :ticket_numbers, :location_id]
  defstruct [:game_id, :pack_number, :ticket_numbers, :location_id]
end
