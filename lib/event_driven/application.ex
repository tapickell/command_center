defmodule EventDriven.Application do
  @moduledoc false

  use Commanded.Application,
    otp_app: :event_driven,
    event_store: [
      adapter: Commanded.EventStore.Adapters.InMemory
      # event_store: EventDriven.EventStore
    ],
    pubsub: :local,
    registry: :local

  def start(_, _) do
    children = [
      EventDriven.EventStore
    ]

    opts = [strategy: :one_for_one, name: EventDriven.Supervisor]
    Supervisor.start_link(children, opts)
  end

  router(EventDriven.Router)
end
