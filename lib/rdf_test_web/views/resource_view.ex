defmodule RdfTestWeb.ResourceView do
  use RdfTestWeb, :view

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Resource

  def empty_resource_changeset() do
    Sparql.change_resource(%Resource{})
  end

  def add_changeset_and_actions_to_assigns(assigns, query, resource) do
    rc = Sparql.change_resource(resource)

    a = Map.put(assigns, :resource, resource)
    a = Map.put(a, :resource_changeset, rc)

    Map.put(
      a,
      :action,
      Routes.query_resource_path(assigns.conn, :update, query.id, resource.id)
    )
  end
end
