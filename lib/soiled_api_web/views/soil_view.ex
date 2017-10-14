defmodule SoiledApiWeb.SoilView do
  use SoiledApiWeb, :view
  alias SoiledApiWeb.SoilView

  def render("index.json", %{soils: soils}) do
    %{
      type: "FeatureCollection",
      features: render_many(soils, SoilView, "soil.json")
    }
  end

  def render("show.json", %{soil: soil}) do
    %{data: render_one(soil, SoilView, "soil.json")}
  end

  def render("soil.json", %{soil: soil}) do
    %{
      type: "Feature",
      geometry: Geo.JSON.encode(soil.wkb_geometry),
      properties: %{
        id: soil.ogc_fid,
        parcnum: soil.parcnum,
        mukey: soil.mukey,
        agval: soil.agval,
        flood: soil.flood,
        forstgrp: soil.forstgrp,
        frostactio: soil.frostactio,
        onsite: soil.onsite
      }
    }
  end
end
