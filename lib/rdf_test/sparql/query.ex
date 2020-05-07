defmodule RdfTest.Sparql.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queries" do
    field :name, :string
    field :query, :string

    timestamps()
  end

  def changeset(query, attrs \\ %{}) do
    query
    |> cast(attrs, [:name, :query])
    |> validate_required([:name, :query])
  end
end
