defmodule EventDriven.TicketPackCommandHandler do
  @moduledoc false
  @behaviour Commanded.Commands.Handler

  alias EventDriven.{
    Commands.AddPackToInventory,
    TicketPack
  }

  def handle(%TicketPack{} = aggregate, %AddPackToInventory{} = command) do
    %AddPackToInventory{
      game_id: game_id,
      pack_number: pack_number,
      location_id: location_id
    } = command

    case TicketPack.add_to_inventory(aggregate, Map.from_struct(command)) do
      {:ok, event} ->
        {:ok, event}

      {:error, error} ->
        {:error, error}
    end
  end
end
