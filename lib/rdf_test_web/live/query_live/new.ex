defmodule RdfTestWeb.QueryLive.New do
  use Phoenix.LiveView, layout: {RdfTestWeb.LayoutView, "live.html"}

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Query
  alias RdfTestWeb.QueryView
  alias RdfTestWeb.Router.Helpers, as: Routes

  def render(assigns) do
    QueryView.render("new.html", assigns)
  end

  def mount(_params, _session, socket) do
    changeset = Sparql.change_query(%Query{})
    socket = assign(socket, changeset: changeset)
    {:ok, socket}
  end

  def handle_event("validate", %{"query" => params}, socket) do
    IO.puts("****New******")
    IO.inspect(params)

    changeset =
      %Query{}
      |> Sparql.change_query(params)
      |> Map.put(:action, :insert)

    IO.inspect(changeset)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"query" => params}, socket) do
    query_response = Sparql.create_query(params)
    IO.inspect(query_response)

    case query_response do
      {:ok, _params} ->
        {:noreply,
         socket
         |> put_flash(:info, "Query saved")
         |> push_redirect(to: Routes.live_path(socket, RdfTestWeb.QueryLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
