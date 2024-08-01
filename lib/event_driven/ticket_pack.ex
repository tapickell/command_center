defmodule EventDriven.TicketPack do
  @moduledoc false
  alias EventDriven.Events.TicketPackAdded
  alias EventDriven.TicketPack

  defstruct [:pack_number, :game_id, :location_id, :added_at, :archived_at]

  def add_to_inventory(%TicketPack{} = tp, pack_number, first_ticket_number) do
    %TicketPack{game_id: game_id, location_id: location_id} = tp

    event = %TicketPackAdded{
      pack_number: pack_number,
      game_id: game_id,
      location_id: location_id,
      first_ticket: first_ticket_number
    }

    {:ok, event}
  end
end
