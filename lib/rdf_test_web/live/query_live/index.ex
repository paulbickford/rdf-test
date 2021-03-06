defmodule RdfTestWeb.QueryLive.Index do
  use Phoenix.LiveView, layout: {RdfTestWeb.LayoutView, "live.html"}

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Query
  alias RdfTestWeb.QueryView
  alias RdfTestWeb.Router.Helpers, as: Routes
  alias RdfTestWeb.QueryLive

  def render(assigns) do
    QueryView.render("index.html", assigns)
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, queries: Sparql.list_sorted_queries())
    {:ok, socket}
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end

  def handle_event("validate_query", %{"name" => query_name}, socket) do
    changeset =
      %Query{}
      |> Sparql.change_query(%{name: query_name})
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("edit_query", %{"id" => query_id}, socket) do
    # query = Sparql.get_query!(query_id)

    {:noreply,
     socket
     |> push_redirect(to: Routes.live_path(socket, QueryLive.Edit, query_id))}
  end

  def handle_event("add_query", %{"name" => query_name}, socket) do
    query_response = Sparql.create_query(%{name: query_name})

    case query_response do
      {:ok, %{id: query_id}} ->
        {
          :noreply,
          push_redirect(
            socket,
            to:
              Routes.live_path(
                socket,
                RdfTestWeb.QueryLive.Edit,
                query_id
              )
          )
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete_query", %{"id" => query_id}, socket) do
    query = Sparql.get_query!(query_id)
    query_response = Sparql.delete_query(query)

    case query_response do
      {:ok, _params} ->
        {:noreply,
         socket
         |> put_flash(:info, "Query deleted")
         |> push_redirect(to: Routes.live_path(socket, __MODULE__))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
