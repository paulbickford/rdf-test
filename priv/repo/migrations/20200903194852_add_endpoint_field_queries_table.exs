defmodule RdfTest.Repo.Migrations.AddEndpointFieldQueriesTable do
  use Ecto.Migration

  def change do
    alter table("queries") do
      add :endpoint, :string
    end
  end
end
