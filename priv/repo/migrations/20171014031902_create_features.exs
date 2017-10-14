defmodule SoiledApi.Repo.Migrations.CreateFeatures do
  use Ecto.Migration

  def change do
    create table(:features) do
      add :geom, :string
      add :properties, :map

      timestamps()
    end

  end
end
