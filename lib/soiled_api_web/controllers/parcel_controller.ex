defmodule SoiledApiWeb.ParcelController do
  use SoiledApiWeb, :controller

  alias SoiledApi.Gis
  alias SoiledApi.Gis.Parcel

  action_fallback SoiledApiWeb.FallbackController

  def index(conn, %{"lng"=>lng, "lat"=>lat} = params) do
    parcels = Gis.list_parcels_at_point(%Geo.Point{coordinates: {lng,lat}, srid: 4326})
    render(conn, "index.json", parcels: parcels)
  end

  def index(conn, _params) do
    parcels = Gis.list_parcels()
    render(conn, "index.json", parcels: parcels)
  end
end
