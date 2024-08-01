defmodule EventDriven.TicketPackEventHandler do
  @moduledoc false
  use Commanded.Event.Handler,
    application: EventDriven,
    name: __MODULE__

  alias EventDriven.Events.TicketPackAdded

  def handle(%TicketPackAdded{} = _event, _metadata) do
    # can return {:error, :reason} | {:error, :already_seen_event}
    :ok
  end
end
