defmodule SoiledApi.Gis.Parcel do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoiledApi.Gis.Parcel
  alias SoiledApi.Gis.Soil


  @primary_key {:ogc_fid, :id, autogenerate: true}
  @foreign_key_type :string
  schema "parcels" do
    field :wkb_geometry, Geo.Geometry
    field :parcnum, :string
    has_many :soils, Soil, foreign_key: :parcnum
  end

  @doc false
  def changeset(%Parcel{} = parcel, attrs) do
    parcel
    |> cast(attrs, [])
    |> validate_required([])
  end
end
