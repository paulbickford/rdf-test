defmodule RdfTest.Sparql do
  @moduledoc """
  The SPARQL context
  """

  alias RdfTest.Sparql.Query
  alias RdfTest.Sparql.Resource
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

  # Resources
  def list_resources do
    Repo.all(Resource)
  end

  def list_sorted_resources do
    Resource
    |> Resource.sort()
    |> Repo.all()
  end

  def change_resource(%Resource{} = resource) do
    Resource.changeset(resource, %{})
  end

  def create_resource(attrs \\ %{}) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Repo.insert()
  end

  def get_resource!(id) do
    Repo.get!(Resource, id)
  end

  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
  end

  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end
end
