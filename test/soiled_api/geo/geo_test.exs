defmodule SoiledApi.GisTest do
  use SoiledApi.DataCase

  alias SoiledApi.Gis

  describe "soils" do
    alias SoiledApi.Gis.Soil

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def soil_fixture(attrs \\ %{}) do
      {:ok, soil} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_soil()

      soil
    end

    test "list_soils/0 returns all soils" do
      soil = soil_fixture()
      assert Geo.list_soils() == [soil]
    end

    test "get_soil!/1 returns the soil with given id" do
      soil = soil_fixture()
      assert Geo.get_soil!(soil.id) == soil
    end

    test "create_soil/1 with valid data creates a soil" do
      assert {:ok, %Soil{} = soil} = Geo.create_soil(@valid_attrs)
    end

    test "create_soil/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_soil(@invalid_attrs)
    end

    test "update_soil/2 with valid data updates the soil" do
      soil = soil_fixture()
      assert {:ok, soil} = Geo.update_soil(soil, @update_attrs)
      assert %Soil{} = soil
    end

    test "update_soil/2 with invalid data returns error changeset" do
      soil = soil_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_soil(soil, @invalid_attrs)
      assert soil == Geo.get_soil!(soil.id)
    end

    test "delete_soil/1 deletes the soil" do
      soil = soil_fixture()
      assert {:ok, %Soil{}} = Geo.delete_soil(soil)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_soil!(soil.id) end
    end

    test "change_soil/1 returns a soil changeset" do
      soil = soil_fixture()
      assert %Ecto.Changeset{} = Geo.change_soil(soil)
    end
  end

  describe "parcels" do
    alias SoiledApi.Gis.Parcel

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def parcel_fixture(attrs \\ %{}) do
      {:ok, parcel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_parcel()

      parcel
    end

    test "list_parcels/0 returns all parcels" do
      parcel = parcel_fixture()
      assert Geo.list_parcels() == [parcel]
    end

    test "get_parcel!/1 returns the parcel with given id" do
      parcel = parcel_fixture()
      assert Geo.get_parcel!(parcel.id) == parcel
    end

    test "create_parcel/1 with valid data creates a parcel" do
      assert {:ok, %Parcel{} = parcel} = Geo.create_parcel(@valid_attrs)
    end

    test "create_parcel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_parcel(@invalid_attrs)
    end

    test "update_parcel/2 with valid data updates the parcel" do
      parcel = parcel_fixture()
      assert {:ok, parcel} = Geo.update_parcel(parcel, @update_attrs)
      assert %Parcel{} = parcel
    end

    test "update_parcel/2 with invalid data returns error changeset" do
      parcel = parcel_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_parcel(parcel, @invalid_attrs)
      assert parcel == Geo.get_parcel!(parcel.id)
    end

    test "delete_parcel/1 deletes the parcel" do
      parcel = parcel_fixture()
      assert {:ok, %Parcel{}} = Geo.delete_parcel(parcel)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_parcel!(parcel.id) end
    end

    test "change_parcel/1 returns a parcel changeset" do
      parcel = parcel_fixture()
      assert %Ecto.Changeset{} = Geo.change_parcel(parcel)
    end
  end
end
