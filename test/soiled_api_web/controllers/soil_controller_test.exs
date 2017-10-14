defmodule SoiledApiWeb.SoilControllerTest do
  use SoiledApiWeb.ConnCase

  alias SoiledApi.Gis
  alias SoiledApi.Gis.Soil

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:soil) do
    {:ok, soil} = Geo.create_soil(@create_attrs)
    soil
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all soils", %{conn: conn} do
      conn = get conn, soil_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create soil" do
    test "renders soil when data is valid", %{conn: conn} do
      conn = post conn, soil_path(conn, :create), soil: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, soil_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, soil_path(conn, :create), soil: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update soil" do
    setup [:create_soil]

    test "renders soil when data is valid", %{conn: conn, soil: %Soil{id: id} = soil} do
      conn = put conn, soil_path(conn, :update, soil), soil: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, soil_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, soil: soil} do
      conn = put conn, soil_path(conn, :update, soil), soil: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete soil" do
    setup [:create_soil]

    test "deletes chosen soil", %{conn: conn, soil: soil} do
      conn = delete conn, soil_path(conn, :delete, soil)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, soil_path(conn, :show, soil)
      end
    end
  end

  defp create_soil(_) do
    soil = fixture(:soil)
    {:ok, soil: soil}
  end
end
