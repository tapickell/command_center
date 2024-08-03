defmodule CommandCenter.Tickets.Inventory do
  defp add_pack(pack_attrs) do
    pack_attrs
    |> Pack.changeset()
    |> Pack.validate()
  end
end
