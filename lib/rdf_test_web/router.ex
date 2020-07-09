defmodule RdfTestWeb.Router do
  use RdfTestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {RdfTestWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RdfTestWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/queries", QueryLive.Index
    live "/queries/:id/edit", QueryLive.Edit
    live "/queries/new", QueryLive.New
    live "/queries/:id", QueryLive.Update

    # live "/queries", QueryLive.Index, :index
    # live "/queries/:id/edit", QueryLive.Edit, :edit
    # live "/queries/new", QueryLive.New, :new
    # live "/queries", QueryLive.Create, :create
    # live "/queries/:id", QueryLive.Update, :update
    # live "/queries/:id", QueryLive.Delete, :delete

    # resources "/queries", QueryController, except: [:show] do
    #   resources "/resources", ResourceController, only: [:create, :delete, :update]
    # end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RdfTestWeb do
  #   pipe_through :api
  # end
end
