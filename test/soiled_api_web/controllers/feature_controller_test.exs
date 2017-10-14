defmodule SoiledApiWeb.FeatureControllerTest do
  use SoiledApiWeb.ConnCase

  alias SoiledApi.ComopositeData
  alias SoiledApi.ComopositeData.Feature

  @create_attrs %{geom: "some geom", properties: %{}}
  @update_attrs %{geom: "some updated geom", properties: %{}}
  @invalid_attrs %{geom: nil, properties: nil}

  def fixture(:feature) do
    {:ok, feature} = ComopositeData.create_feature(@create_attrs)
    feature
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all features", %{conn: conn} do
      conn = get conn, feature_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feature" do
    test "renders feature when data is valid", %{conn: conn} do
      conn = post conn, feature_path(conn, :create), feature: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, feature_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "geom" => "some geom",
        "properties" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, feature_path(conn, :create), feature: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feature" do
    setup [:create_feature]

    test "renders feature when data is valid", %{conn: conn, feature: %Feature{id: id} = feature} do
      conn = put conn, feature_path(conn, :update, feature), feature: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, feature_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "geom" => "some updated geom",
        "properties" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn, feature: feature} do
      conn = put conn, feature_path(conn, :update, feature), feature: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete feature" do
    setup [:create_feature]

    test "deletes chosen feature", %{conn: conn, feature: feature} do
      conn = delete conn, feature_path(conn, :delete, feature)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, feature_path(conn, :show, feature)
      end
    end
  end

  defp create_feature(_) do
    feature = fixture(:feature)
    {:ok, feature: feature}
  end
end
