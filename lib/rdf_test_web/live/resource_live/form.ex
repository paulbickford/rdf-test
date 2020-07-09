defmodule RdfTestWeb.ResourceLive.Form do
  use Phoenix.LiveComponent

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Resource
  alias RdfTestWeb.ResourceView

  def render(assigns) do
    ResourceView.render("form.html", assigns)
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    %{resource_id: resource_id} = assigns

    changeset =
      case resource_id do
        "new" ->
          %Resource{}
          |> Sparql.change_resource()
          |> Map.put(:action, :insert)

        _ ->
          Sparql.get_resource!(resource_id)
          |> Sparql.change_resource()
          |> Map.put(:action, :update)
      end

    {:ok, assign(socket, resource_id: resource_id, changeset: changeset)}
  end
end
