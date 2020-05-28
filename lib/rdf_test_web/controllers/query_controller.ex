defmodule RdfTestWeb.QueryController do
  use RdfTestWeb, :controller

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Query
  alias RdfTest.Sparql.Resource

  plug :load_resources when action in [:create, :new, :create, :edit, :update]

  defp load_resources(conn, _) do
    assign(conn, :resources, Sparql.list_sorted_resources())
  end

  def index(conn, _params) do
    queries = Sparql.list_queries()
    render(conn, "index.html", queries: queries)
  end

  def new(conn, _params) do
    changeset = Sparql.change_query(%Query{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"query" => query_params}) do
    case Sparql.create_query(query_params) do
      {:ok, query} ->
        conn
        |> put_flash(:info, "Query created successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    query = Sparql.get_query!(id)
    changeset = Sparql.change_query(query)

    render(conn, "edit.html",
      query: query,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "query" => query_params}) do
    query = Sparql.get_query!(id)

    case Sparql.update_query(query, query_params) do
      {:ok, query} ->
        conn
        |> put_flash(:info, "Query updated successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", query: query, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    query = Sparql.get_query!(id)
    {:ok, _query} = Sparql.delete_query(query)

    conn
    |> put_flash(:info, "Query deleted successfully.")
    |> redirect(to: Routes.query_path(conn, :index))
  end
end
