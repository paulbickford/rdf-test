defmodule RdfTest.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :prefix, :string, null: false
      add :iri, :string

      timestamps()
    end

    create unique_index(:resources, [:prefix])
  end
end
