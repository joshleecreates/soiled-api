
defmodule SoiledApiWeb.FeatureController do
  use SoiledApiWeb, :controller
  alias SoiledApi.ComopositeData
  alias SoiledApi.ComopositeData.Feature

  action_fallback SoiledApiWeb.FallbackController

  def index(conn, %{"lng"=> lng, "lat"=> lat} = params) do
    point = %Geo.Point{coordinates: {lng, lat}, srid: 4326}
    features = ComopositeData.features_at_point(point)
    render(conn, "index.json", features: features)
  end

  def index(conn, _params) do
    features = ComopositeData.list_features()
    render(conn, "index.json", features: features)
  end

  def create(conn, %{"feature" => feature_params}) do
    with {:ok, %Feature{} = feature} <- ComopositeData.create_feature(feature_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", feature_path(conn, :show, feature))
      |> render("show.json", feature: feature)
    end
  end

  def show(conn, %{"ogc_id" => id}) do
    feature = ComopositeData.get_feature!(id)
    render(conn, "show.json", feature: feature)
  end

  def update(conn, %{"ogc_id" => id, "feature" => feature_params}) do
    feature = ComopositeData.get_feature!(id)

    with {:ok, %Feature{} = feature} <- ComopositeData.update_feature(feature, feature_params) do
      render(conn, "show.json", feature: feature)
    end
  end

  def delete(conn, %{"ogc_id" => id}) do
    feature = ComopositeData.get_feature!(id)
    with {:ok, %Feature{}} <- ComopositeData.delete_feature(feature) do
      send_resp(conn, :no_content, "")
    end
  end
end
