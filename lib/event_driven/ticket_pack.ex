defmodule EventDriven.TicketPack do
  @moduledoc false
  alias EventDriven.Events.TicketPackAdded
  alias CommandCenter.Tickets.Inventory

  defstruct [:pack_number, :game_id, :location_id, :added_at, :archived_at]

  def add_to_inventory(%__MODULE__{}, params) do
    case Inventory.add_pack(params) do
      {:ok, pack} ->
        created_at = DateTime.utc_now()

        event = %TicketPackAdded{
          pack_number: pack.pack_number,
          game_id: pack.game_id,
          location_id: pack.location_id,
          added_at: created_at
        }

        {:ok, event}

      {:error, _cs} = error ->
        error
    end
  end

  def apply(%__MODULE__{} = tp, %TicketPackAdded{} = event) do
    %TicketPackAdded{
      game_id: game_id,
      pack_number: pack_number,
      location_id: location_id,
      added_at: added_at
    } = event

    %__MODULE__{
      tp
      | game_id: game_id,
        pack_number: pack_number,
        location_id: location_id,
        added_at: added_at
    }
  end
end
