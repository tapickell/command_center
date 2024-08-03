defmodule CommandCenter.Tickets.Inventory do
  alias CommandCenter.Tickets.Pack

  def add_pack(pack_attrs) do
    pack_attrs
    |> Pack.changeset()
    |> Pack.validate()
  end
end
