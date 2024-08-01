defmodule EventDriven.Supervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = [
      EventDriven.Application
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
