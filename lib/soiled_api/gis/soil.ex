defmodule SoiledApi.Gis.Soil do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoiledApi.Gis.Soil
  alias SoiledApi.Gis.Parcel

  @primary_key {:ogc_fid, :id, autogenerate: true}
  schema "soils" do
    field :wkb_geometry, Geo.Geometry
    field :parcnum, :string
  end

  @doc false
  def changeset(%Soil{} = soil, attrs) do
    soil
    |> cast(attrs, [])
    |> validate_required([])
  end
end
