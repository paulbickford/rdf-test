defmodule RdfTestWeb.QueryLive.Result do
  use Phoenix.LiveComponent

  import RdfTestWeb.ErrorHelpers

  alias RdfTestWeb.QueryView

  def render(assigns) do
    template =
      case assigns.result_type do
        :graph ->
          "result_graph.html"

        :value ->
          "result_value.html"

        _ ->
          "result_nil.html"
      end

    QueryView.render(template, assigns)
  end
end
