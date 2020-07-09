defmodule RdfTestWeb.QueryLive.Index do
  use Phoenix.LiveView, layout: {RdfTestWeb.LayoutView, "live.html"}

  alias RdfTest.Sparql
  alias RdfTestWeb.QueryView
  alias RdfTestWeb.Router.Helpers, as: Routes

  def render(assigns) do
    QueryView.render("index.html", assigns)
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, queries: Sparql.list_queries())
    {:ok, socket}
  end

  def handle_event("delete_query", %{"id" => query_id}, socket) do
    query = Sparql.get_query!(query_id)
    query_response = Sparql.delete_query(query)

    case query_response do
      {:ok, _params} ->
        {:noreply,
         socket
         |> put_flash(:info, "Query deleted")
         |> push_redirect(to: Routes.live_path(socket, RdfTestWeb.QueryLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
