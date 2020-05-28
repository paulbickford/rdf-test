defmodule RdfTest.Sparql.Resource do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "resources" do
    field :prefix, :string, unique: true
    field :iri, :string

    timestamps()
  end

  def changeset(resource, attrs \\ %{}) do
    resource
    |> cast(attrs, [:prefix, :iri])
    |> validate_required([:prefix, :iri])
    |> unique_constraint(:prefix)
  end

  def sort(query) do
    from r in query, order_by: r.prefix
  end
end
