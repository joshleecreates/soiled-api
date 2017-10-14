defmodule SoiledApiWeb.ParcelView do
  use SoiledApiWeb, :view
  alias SoiledApiWeb.ParcelView

  def render("index.json", %{parcels: parcels}) do
    %{data: render_many(parcels, ParcelView, "parcel.json")}
  end

  def render("show.json", %{parcel: parcel}) do
    %{data: render_one(parcel, ParcelView, "parcel.json")}
  end

  def render("parcel.json", %{parcel: parcel}) do
    %{
      id: parcel.ogc_fid,
      parcnum: parcel.parcnum,
      geometry: Geo.JSON.encode(parcel.wkb_geometry)
    }
  end
end
