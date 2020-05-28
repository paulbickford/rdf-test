defmodule RdfTestWeb.QueryView do
  use RdfTestWeb, :view

  def add_resource_form_values_to_assigns(assigns, resources, query) do
    a = Map.put(assigns, :resources, resources)
    Map.put(a, :query, query)
  end
end
