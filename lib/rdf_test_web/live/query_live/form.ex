defmodule RdfTestWeb.QueryLive.Form do
  use Phoenix.LiveComponent

  import RdfTestWeb.ErrorHelpers

  alias RdfTestWeb.QueryView
  # alias RdfTestWeb.Router.Helpers, as: Routes

  def render(assigns) do
    QueryView.render("form.html", assigns)
  end
end
