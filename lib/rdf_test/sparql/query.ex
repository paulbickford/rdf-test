defmodule RdfTest.Sparql.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queries" do
    field :name, :string, unique: true
    field :query, :string

    timestamps()
  end

  def changeset(query, attrs \\ %{}) do
    query
    |> cast(attrs, [:name, :query])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
