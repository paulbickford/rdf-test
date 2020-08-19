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
    socket = assign(socket, query: query, changeset: changeset)
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
end
