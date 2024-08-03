defmodule EventDriven.TicketPack do
  @moduledoc false
  alias EventDriven.Events.TicketPackAdded
  alias EventDriven.TicketPack

  defstruct [:pack_number, :game_id, :location_id, :added_at, :archived_at]

  def add_to_inventory(%TicketPack{}, params) do
    %{game_id: game_id, pack_number: pack_number, location_id: location_id} = params

    # is this where an actual insertion would be ??
    # Nope this is later in a projection
    # this should call changeset operations on Inventory.add_pack..
    # catch errors and return or return ok event
    created_at = DateTime.utc_now()

    event = %TicketPackAdded{
      pack_number: pack_number,
      game_id: game_id,
      location_id: location_id,
      added_at: created_at
    }

    {:ok, event}
  end

  def apply(%TicketPack{} = tp, %TicketPackAdded{} = event) do
    %TicketPackAdded{
      game_id: game_id,
      pack_number: pack_number,
      location_id: location_id,
      added_at: added_at
    } = event

    %TicketPack{
      tp
      | game_id: game_id,
        pack_number: pack_number,
        location_id: location_id,
        added_at: added_at
    }
  end
end
