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

  def list_sorted_queries do
    Query
    |> Query.sort()
    |> Repo.all()
  end

  def change_query(%Query{} = query, attrs \\ %{}) do
    Query.changeset(query, attrs)
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

  def change_resource(%Resource{} = resource, attr \\ %{}) do
    Resource.changeset(resource, attr)
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

  def sparql_query(query, endpoint) do
    case SPARQL.Client.query(query, endpoint) do
      {:ok, result} ->
        format_result(result)

      {:error, error} ->
        "Error: #{error}"
    end
  end

  defp format_result(%RDF.Graph{} = result) do
    {:graph, result}
  end

  defp format_result(%SPARQL.Query.Result{} = result) do
    %{results: raw_results, variables: vars} = result

    results =
      raw_results
      |> Enum.map(fn row -> format_row(row) end)

    {:value, %{variables: vars, results: results}}
  end

  defp format_row(row) do
    row
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.merge(acc, %{k => value_to_string(v)})
    end)
  end

  defp value_to_string(%RDF.Literal{} = value) do
    value.value
  end

  defp value_to_string(%RDF.IRI{} = value) do
    resources = list_resources()

    resource =
      resources
      |> Enum.find(fn resource -> String.starts_with?(value.value, extract_iri(resource)) end)

    if is_nil(resource) do
      value.value
    else
      String.replace_prefix(value.value, extract_iri(resource) <> "/", resource.prefix <> ":")
    end
  end

  defp value_to_string(value) do
    value
  end

  defp extract_iri(resource) do
    resource.iri
    |> String.replace_prefix("<", "")
    |> String.replace_suffix(">", "")
    |> String.replace_suffix("#", "")
    |> String.replace_suffix("/", "")
  end
end
