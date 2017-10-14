defmodule SoiledApiWeb.SoilView do
  use SoiledApiWeb, :view
  alias SoiledApiWeb.SoilView

  def render("index.json", %{soils: soils}) do
    %{data: render_many(soils, SoilView, "soil.json")}
  end

  def render("show.json", %{soil: soil}) do
    %{data: render_one(soil, SoilView, "soil.json")}
  end

  def render("soil.json", %{soil: soil}) do
    %{id: soil.id}
  end
end
