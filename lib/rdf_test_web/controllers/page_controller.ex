defmodule RdfTestWeb.PageController do
  use RdfTestWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/queries")
  end
end
