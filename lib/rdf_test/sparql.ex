defmodule RdfTest.Sparql do
  @moduledoc """
  The SPARQL context
  """

  alias RdfTest.Sparql.Query
  alias RdfTest.Repo

  def list_queries do
    Repo.all(Query)
  end
end
