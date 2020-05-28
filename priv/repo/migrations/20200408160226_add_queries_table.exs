defmodule RdfTest.Repo.Migrations.AddQueriesTable do
  use Ecto.Migration

  def change do
    create table(:queries) do
      add :name, :string, null: false
      add :query, :text

      timestamps()
    end

    create unique_index(:queries, [:name])
  end
end
