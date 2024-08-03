defmodule CommandCenter.Tickets.Pack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packs" do
    field :pack_number, :string
    field :game_id, :string
    field :location_id, :string

    field :added_at, :timestamp
    field :archived_at, :timestamp
    # belongs_to :game, Game
    # belongs_to :location, Location
  end

  @doc false
  def changeset(pack, attrs) do
    pack
    |> cast(attrs, [
      :game_id,
      :location_id,
      :pack_number,
      :added_at,
      :archived_at
    ])
    |> validate_required([:pack_number, :game_id, :location_id])

    # how to do this outside of ecto ??
    # |> unique_constraint([:pack_number])
    # |> defered_validation()
  end

  @spec validate(Changeset.t()) :: {:ok, Changeset.t()} | {:error, Changeset.t()}
  def validate(pack) do
    Ecto.Changeset.apply_action(pack, :update)
  end

  # WIP - feels like rewriting Ecto to make changes persist to the struct
  defp defered_validation(%Ecto.Changeset{valid?: true, changes: changes} = cs) do
    schema = cs.__struct__
    writable_fields = schema.__schema__(:writable_fields)
    changes = Map.take(changes, writable_fields)

    if seems_legit?() do
      {:ok, %Pack{}}
    else
      {:error, :pack_already_exists}
    end
  end

  defp defered_validation(changeset), do: changeset

  defp seems_legit?, do: true
end
