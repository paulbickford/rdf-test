defmodule RdfTest.Repo.Migrations.CreateUniqueNameIndex do
  use Ecto.Migration

  def change do
    create index("queries", [:name], unique: true)
  end
end
