defmodule EventDriven.Commands.AddPackToInventory do
  @enforce_keys [:pack_number, :ticket_numbers]
  defstruct [:pack_number, :ticket_numbers]
end
