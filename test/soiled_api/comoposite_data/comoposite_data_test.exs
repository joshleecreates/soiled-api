defmodule SoiledApi.ComopositeDataTest do
  use SoiledApi.DataCase

  alias SoiledApi.ComopositeData

  describe "features" do
    alias SoiledApi.ComopositeData.Feature

    @valid_attrs %{geom: "some geom", properties: %{}}
    @update_attrs %{geom: "some updated geom", properties: %{}}
    @invalid_attrs %{geom: nil, properties: nil}

    def feature_fixture(attrs \\ %{}) do
      {:ok, feature} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ComopositeData.create_feature()

      feature
    end

    test "list_features/0 returns all features" do
      feature = feature_fixture()
      assert ComopositeData.list_features() == [feature]
    end

    test "get_feature!/1 returns the feature with given id" do
      feature = feature_fixture()
      assert ComopositeData.get_feature!(feature.id) == feature
    end

    test "create_feature/1 with valid data creates a feature" do
      assert {:ok, %Feature{} = feature} = ComopositeData.create_feature(@valid_attrs)
      assert feature.geom == "some geom"
      assert feature.properties == %{}
    end

    test "create_feature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ComopositeData.create_feature(@invalid_attrs)
    end

    test "update_feature/2 with valid data updates the feature" do
      feature = feature_fixture()
      assert {:ok, feature} = ComopositeData.update_feature(feature, @update_attrs)
      assert %Feature{} = feature
      assert feature.geom == "some updated geom"
      assert feature.properties == %{}
    end

    test "update_feature/2 with invalid data returns error changeset" do
      feature = feature_fixture()
      assert {:error, %Ecto.Changeset{}} = ComopositeData.update_feature(feature, @invalid_attrs)
      assert feature == ComopositeData.get_feature!(feature.id)
    end

    test "delete_feature/1 deletes the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{}} = ComopositeData.delete_feature(feature)
      assert_raise Ecto.NoResultsError, fn -> ComopositeData.get_feature!(feature.id) end
    end

    test "change_feature/1 returns a feature changeset" do
      feature = feature_fixture()
      assert %Ecto.Changeset{} = ComopositeData.change_feature(feature)
    end
  end
end
