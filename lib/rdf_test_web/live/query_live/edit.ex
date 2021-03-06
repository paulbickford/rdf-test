defmodule RdfTestWeb.QueryLive.Edit do
  use Phoenix.LiveView, layout: {RdfTestWeb.LayoutView, "live.html"}

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Query
  alias RdfTestWeb.QueryView
  # alias RdfTestWeb.Router.Helpers, as: Routes

  def render(assigns) do
    QueryView.render("edit.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    query = Sparql.get_query!(id)
    changeset = Sparql.change_query(query)

    socket =
      assign(socket, query: query, changeset: changeset, result_type: :undefined, result: "")

    {:noreply, socket}
  end

  def handle_event("validate", %{"query" => params}, socket) do
    changeset =
      %Query{}
      |> Sparql.change_query(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"query" => params}, socket) do
    query_response = Sparql.update_query(socket.assigns.query, params)

    case query_response do
      {:ok, _params} ->
        {:noreply,
         socket
         |> put_flash(:info, "Query saved")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("drop-resource", %{"id" => resource_id}, socket) do
    resource_id = String.to_integer(String.replace_leading(resource_id, "resource-", ""))
    resource = Sparql.get_resource!(resource_id)

    text = "PREFIX #{resource.prefix}: #{resource.iri}\n"

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_change(
        :query,
        text <> Ecto.Changeset.get_field(socket.assigns.changeset, :query)
      )

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("run-query", _params, socket) do
    query_string = Ecto.Changeset.get_field(socket.assigns.changeset, :query)
    endpoint = Ecto.Changeset.get_field(socket.assigns.changeset, :endpoint)
    {result_type, result} = Sparql.sparql_query(query_string, endpoint)
    grid_columns = grid_columns(result.variables, Enum.count(result.results))

    {:noreply,
     assign(socket, result_type: result_type, result: result, grid_columns: grid_columns)}
  end

  defp grid_columns(column_labels, number_rows) do
    ("\"" <>
       String.trim(
         Enum.reduce(
           column_labels,
           "",
           &(&2 <> " " <> grid_area_name(&1))
         )
       ) <> "\"\n")
    |> String.duplicate(number_rows)
  end

  def grid_area_name(name) do
    String.replace(String.trim(name), ~r/\s/, "-")
  end
end
