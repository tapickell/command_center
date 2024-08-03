defmodule CommandCenter.Tickets.Pack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packs" do
    field :pack_number, :string
    field :game_id, :string
    field :location_id, :integer

    field :added_at, :utc_datetime
    field :archived_at, :utc_datetime
    # belongs_to :game, Game
    # belongs_to :location, Location
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

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
end
