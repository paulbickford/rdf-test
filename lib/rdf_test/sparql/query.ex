defmodule RdfTest.Sparql.Query do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  def sort(query) do
    from q in query, order_by: q.name
  end
end
