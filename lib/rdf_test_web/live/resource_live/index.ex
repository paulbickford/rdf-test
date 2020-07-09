defmodule RdfTestWeb.ResourceLive.Index do
  use Phoenix.LiveComponent

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Resource
  alias RdfTestWeb.ResourceView
  alias RdfTestWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ResourceView.render("index.html", assigns)
  end

  def mount(socket) do
    resource_changeset = Sparql.change_resource(%Resource{})
    resources = Sparql.list_sorted_resources()
    {:ok, assign(socket, resources: resources, new_changeset: resource_changeset)}
  end

  def changeset_list(resource_list) do
    cs_list =
      Enum.map(resource_list, fn resource ->
        resource
        |> Sparql.change_resource(resource)
        |> Map.put(:action, :update)
      end)

    empty_changeset =
      %Resource{}
      |> Sparql.change_resource()
      |> Map.put(:action, :insert)

    List.insert_at(cs_list, -1, empty_changeset)
  end

  def handle_event("validate", params, socket) do
    %{"resource" => resource_params} = params

    %{"resource_id" => resource_id} = resource_params

    changeset =
      case resource_id do
        "new" ->
          %Resource{}
          |> Sparql.change_resource(resource_params)
          |> Map.put(:action, :insert)

        _ ->
          %Resource{}
          |> Sparql.change_resource(resource_params)
          |> Map.put(:action, :update)
      end

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"resource" => resource_params}, socket) do
    resource_response =
      case resource_params["resource_id"] do
        "new" ->
          Sparql.create_resource(resource_params)

        _ ->
          Sparql.update_resource(socket.assigns.resource, resource_params)
      end

    case resource_response do
      {:ok, _params} ->
        resources = Sparql.list_sorted_resources()

        {:noreply,
         socket
         |> put_flash(:info, "Resource saved")
         |> assign(resources: resources)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete_resource", %{"id" => resource_id}, socket) do
    resource = Sparql.get_resource!(resource_id)
    resource_response = Sparql.delete_resource(resource)

    case resource_response do
      {:ok, _params} ->
        resources = Sparql.list_sorted_resources()

        {:noreply,
         socket
         |> put_flash(:info, "Resource deleted")
         |> assign(resources: resources)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
