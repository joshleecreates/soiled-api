defmodule SoiledApiWeb.SoilController do
  use SoiledApiWeb, :controller

  alias SoiledApi.Gis
  alias SoiledApi.Gis.Soil

  action_fallback SoiledApiWeb.FallbackController

  def index(conn, _params) do
    soils = Gis.list_soils()
    render(conn, "index.json", soils: soils)
  end

  def create(conn, %{"soil" => soil_params}) do
    with {:ok, %Soil{} = soil} <- Gis.create_soil(soil_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", soil_path(conn, :show, soil))
      |> render("show.json", soil: soil)
    end
  end

  def show(conn, %{"id" => id}) do
    soil = Gis.get_soil!(id)
    render(conn, "show.json", soil: soil)
  end

  def update(conn, %{"id" => id, "soil" => soil_params}) do
    soil = Gis.get_soil!(id)

    with {:ok, %Soil{} = soil} <- Gis.update_soil(soil, soil_params) do
      render(conn, "show.json", soil: soil)
    end
  end

  def delete(conn, %{"id" => id}) do
    soil = Gis.get_soil!(id)
    with {:ok, %Soil{}} <- Gis.delete_soil(soil) do
      send_resp(conn, :no_content, "")
    end
  end
end
