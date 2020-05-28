defmodule RdfTestWeb.ResourceController do
  use RdfTestWeb, :controller

  alias RdfTest.Sparql
  alias RdfTest.Sparql.Resource

  def create(conn, %{"resource" => resource_params, "query_id" => query_id}) do
    query = Sparql.get_query!(query_id)

    case Sparql.create_resource(resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))
    end
  end

  def update(conn, %{"id" => id, "resource" => resource_params, "query_id" => query_id}) do
    resource = Sparql.get_resource!(id)
    query = Sparql.get_query!(query_id)

    case Sparql.update_resource(resource, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: Routes.query_path(conn, :edit, query))
    end
  end

  def delete(conn, %{"id" => id, "query_id" => query_id}) do
    resource = Sparql.get_resource!(id)
    query = Sparql.get_query!(query_id)
    {:ok, _resource} = Sparql.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: Routes.query_path(conn, :edit, query))
  end
end
