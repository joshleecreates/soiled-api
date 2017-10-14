defmodule SoiledApi.ComopositeData.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoiledApi.ComopositeData.Feature


  schema "features" do
    field :geom, :string
    field :properties, :map

    timestamps()
  end

  @doc false
  def changeset(%Feature{} = feature, attrs) do
    feature
    |> cast(attrs, [:geom, :properties])
    |> validate_required([:geom, :properties])
  end
end
