defmodule SoiledApi.ComopositeData.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoiledApi.ComopositeData.Feature

  @primary_key {:ogc_fid, :id, autogenerate: true}
  schema "layer_features" do
    field :wkb_geometry, Geo.Geometry
    # field :parcel_num, :string
    # field :p_span, :string
    # field :proptype, :string
    # field :town, :string
    # field :year, :integer
    # field :fips8, :integer
    # field :areasymbol, :string
    # field :spatialver, :integer
    # field :musym, :string
    # field :mukey, :string
    # field :muid, :string
    # field :mukind, :string

  end

  @doc false
  def changeset(%Feature{} = feature, attrs) do
    feature
    |> cast(attrs, [])
    |> validate_required([])
  end
end
