defmodule RdfTest.Sparql do
  @moduledoc """
  The SPARQL context
  """

  alias RdfTest.Sparql.Query
  alias RdfTest.Repo

  def list_queries do
    Repo.all(Query)
  end

  def change_query(%Query{} = query) do
    Query.changeset(query, %{})
  end

  def create_query(attrs \\ %{}) do
    %Query{}
    |> Query.changeset(attrs)
    |> Repo.insert()
  end

  def get_query!(id) do
    Repo.get!(Query, id)
  end

  def update_query(%Query{} = query, attrs) do
    query
    |> Query.changeset(attrs)
    |> Repo.update()
  end

  def delete_query(%Query{} = query) do
    Repo.delete(query)
  end
end
