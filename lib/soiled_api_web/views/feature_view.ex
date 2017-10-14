defmodule SoiledApiWeb.FeatureView do
  use SoiledApiWeb, :view
  alias SoiledApiWeb.FeatureView

  def render("index.json", %{features: features}) do
    %{data: render_many(features, FeatureView, "feature.json")}
  end

  def render("show.json", %{feature: feature}) do
    %{data: render_one(feature, FeatureView, "feature.json")}
  end

  def render("feature.json", %{feature: feature}) do
    %{id: feature.id,
      geom: feature.geom,
      properties: feature.properties}
  end
end
