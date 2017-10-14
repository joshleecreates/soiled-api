defmodule SoiledApiWeb.ParcelControllerTest do
  use SoiledApiWeb.ConnCase

  alias SoiledApi.Gis
  alias SoiledApi.Gis.Parcel

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:parcel) do
    {:ok, parcel} = Geo.create_parcel(@create_attrs)
    parcel
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all parcels", %{conn: conn} do
      conn = get conn, parcel_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create parcel" do
    test "renders parcel when data is valid", %{conn: conn} do
      conn = post conn, parcel_path(conn, :create), parcel: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, parcel_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, parcel_path(conn, :create), parcel: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update parcel" do
    setup [:create_parcel]

    test "renders parcel when data is valid", %{conn: conn, parcel: %Parcel{id: id} = parcel} do
      conn = put conn, parcel_path(conn, :update, parcel), parcel: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, parcel_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, parcel: parcel} do
      conn = put conn, parcel_path(conn, :update, parcel), parcel: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete parcel" do
    setup [:create_parcel]

    test "deletes chosen parcel", %{conn: conn, parcel: parcel} do
      conn = delete conn, parcel_path(conn, :delete, parcel)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, parcel_path(conn, :show, parcel)
      end
    end
  end

  defp create_parcel(_) do
    parcel = fixture(:parcel)
    {:ok, parcel: parcel}
  end
end
