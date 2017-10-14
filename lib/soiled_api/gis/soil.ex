defmodule SoiledApi.Gis.Soil do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoiledApi.Gis.Soil
  alias SoiledApi.Gis.Parcel

  @primary_key {:ogc_fid, :id, autogenerate: true}
  schema "soils" do
    field :wkb_geometry, Geo.Geometry
    field :parcnum, :string
    field :mukey, :string
    field :agval, :float
    field :flood, :string
    field :forstgrp, :float
    field :frostactio, :string
    field :onsite, :string
  end

  @doc false
  def changeset(%Soil{} = soil, attrs) do
    soil
    |> cast(attrs, [])
    |> validate_required([])
  end
end
