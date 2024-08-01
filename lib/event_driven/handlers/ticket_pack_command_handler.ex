defmodule EventDriven.TicketPackCommandHandler do
  @moduledoc false
  @behaviour Commanded.Commands.Handler

  alias EventDriven.{
    Commands.AddPackToInventory,
    TicketPack
  }

  def handle(%TicketPack{} = aggregate, %AddPackToInventory{} = command) do
    # Validate Pack here before adding to Inventory
    # return {:error, reason} on validation failure
    %TicketPack{game_id: game_id, location_id: location_id} = aggregate
    %AddPackToInventory{pack_number: pack_number, ticket_numbers: ticket_numbers} = command

    case validate_add_to_inventory(game_id, pack_number, ticket_numbers, location_id) do
      :ok ->
        [first_ticket_number | _rest] = Enum.to_list(ticket_numbers)
        TicketPack.add_to_inventory(aggregate, pack_number, first_ticket_number)

      {:error, error} ->
        {:error, error}
    end
  end

  defp validate_add_to_inventory(_game_id, _pack_number, _ticket_numbers, _location_id) do
    # figure out simple validation for testing like len ticket_numbers is valid for game config
    :ok
  end
end
