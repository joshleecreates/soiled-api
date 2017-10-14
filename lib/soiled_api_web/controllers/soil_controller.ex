defmodule SoiledApiWeb.SoilController do
  use SoiledApiWeb, :controller

  alias SoiledApi.Gis
  alias SoiledApi.Gis.Soil

  action_fallback SoiledApiWeb.FallbackController

  def index(conn, %{"parcnum"=>parcnum}) do
    soils = Gis.list_soils_by_parcnum(parcnum)
    render(conn, "index.json", soils: soils)
  end

  def index(conn, _params) do
    soils = Gis.list_soils()
    render(conn, "index.json", soils: soils)
  end

  def show(conn, %{"id" => id}) do
    soil = Gis.get_soil!(id)
    render(conn, "show.json", soil: soil)
  end
end
