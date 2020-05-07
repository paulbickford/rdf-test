defmodule RdfTest.Repo.Migrations.AddQueriesTable do
  use Ecto.Migration

  def change do
    create table("queries") do
      add :name, :string
      add :query, :text

      timestamps()
    end
  end
end
