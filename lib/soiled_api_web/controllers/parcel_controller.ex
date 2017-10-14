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

  def create(conn, %{"parcel" => parcel_params}) do
    with {:ok, %Parcel{} = parcel} <- Gis.create_parcel(parcel_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", parcel_path(conn, :show, parcel))
      |> render("show.json", parcel: parcel)
    end
  end

  def show(conn, %{"id" => id}) do
    parcel = Gis.get_parcel!(id)
    render(conn, "show.json", parcel: parcel)
  end

  def update(conn, %{"id" => id, "parcel" => parcel_params}) do
    parcel = Gis.get_parcel!(id)

    with {:ok, %Parcel{} = parcel} <- Gis.update_parcel(parcel, parcel_params) do
      render(conn, "show.json", parcel: parcel)
    end
  end

  def delete(conn, %{"id" => id}) do
    parcel = Gis.get_parcel!(id)
    with {:ok, %Parcel{}} <- Gis.delete_parcel(parcel) do
      send_resp(conn, :no_content, "")
    end
  end
end
