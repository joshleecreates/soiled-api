defmodule SoiledApi.Gis do
  @moduledoc """
  The Geo context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias SoiledApi.Repo
  alias SoiledApi.Gis.Parcel
  alias SoiledApi.Gis.Soil
  require Logger

  @doc """
  Returns the list of soils.

  ## Examples

      iex> list_soils()
      [%Soil{}, ...]

  """
  def list_soils do
    Repo.all(Soil)
  end

  def list_soils_by_parcnum(parcnum) do
    Repo.all(soils_by_parcnum(parcnum))
  end

  @doc """
  Gets a single soil.

  Raises `Ecto.NoResultsError` if the Soil does not exist.

  ## Examples

      iex> get_soil!(123)
      %Soil{}

      iex> get_soil!(456)
      ** (Ecto.NoResultsError)

  """
  def get_soil!(id), do: Repo.get!(Soil, id)

  @doc """
  Creates a soil.

  ## Examples

      iex> create_soil(%{field: value})
      {:ok, %Soil{}}

      iex> create_soil(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_soil(attrs \\ %{}) do
    %Soil{}
    |> Soil.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a soil.

  ## Examples

      iex> update_soil(soil, %{field: new_value})
      {:ok, %Soil{}}

      iex> update_soil(soil, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_soil(%Soil{} = soil, attrs) do
    soil
    |> Soil.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Soil.

  ## Examples

      iex> delete_soil(soil)
      {:ok, %Soil{}}

      iex> delete_soil(soil)
      {:error, %Ecto.Changeset{}}

  """
  def delete_soil(%Soil{} = soil) do
    Repo.delete(soil)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking soil changes.

  ## Examples

      iex> change_soil(soil)
      %Ecto.Changeset{source: %Soil{}}

  """
  def change_soil(%Soil{} = soil) do
    Soil.changeset(soil, %{})
  end

  @doc """
  Returns the list of parcels.

  ## Examples

      iex> list_parcels()
      [%Parcel{}, ...]

  """
  def list_parcels_at_point(point) do
    Repo.all(parcels_containing_point_query(point))
  end

  def list_parcels do
    Repo.all(Parcel)
  end

  @doc """
  Gets a single parcel.

  Raises `Ecto.NoResultsError` if the Parcel does not exist.

  ## Examples

      iex> get_parcel!(123)
      %Parcel{}

      iex> get_parcel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parcel!(id), do: Repo.get!(Parcel, id)

  @doc """
  Creates a parcel.

  ## Examples

      iex> create_parcel(%{field: value})
      {:ok, %Parcel{}}

      iex> create_parcel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parcel(attrs \\ %{}) do
    %Parcel{}
    |> Parcel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parcel.

  ## Examples

      iex> update_parcel(parcel, %{field: new_value})
      {:ok, %Parcel{}}

      iex> update_parcel(parcel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parcel(%Parcel{} = parcel, attrs) do
    parcel
    |> Parcel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Parcel.

  ## Examples

      iex> delete_parcel(parcel)
      {:ok, %Parcel{}}

      iex> delete_parcel(parcel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parcel(%Parcel{} = parcel) do
    Repo.delete(parcel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parcel changes.

  ## Examples

      iex> change_parcel(parcel)
      %Ecto.Changeset{source: %Parcel{}}

  """
  def change_parcel(%Parcel{} = parcel) do
    Parcel.changeset(parcel, %{})
  end

  defp soils_by_parcnum(parcnum) do
    from soil in Soil, where: soil.parcnum == ^parcnum
  end

  defp parcels_containing_point_query(geom) do
    from parcel in Parcel, limit: 5, where: st_within(^geom, parcel.wkb_geometry)
  end
end
