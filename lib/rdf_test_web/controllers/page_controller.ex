defmodule RdfTestWeb.PageController do
  use RdfTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
