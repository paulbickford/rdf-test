defmodule RdfTestWeb.Router do
  use RdfTestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RdfTestWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/queries", QueryController, except: [:show] do
      resources "/resources", ResourceController, only: [:create, :delete, :update]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RdfTestWeb do
  #   pipe_through :api
  # end
end
