defmodule Tasks2Web.Router do
  use Tasks2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug Tasks2Web.Plugs.FetchSession
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #TODO: AJAX here? or API?
  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug Tasks2Web.Plugs.FetchSession
  end

  scope "/", Tasks2Web do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/tasks", TaskController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  #scope "/api/v1", Tasks2Web do
  #  pipe_through :api
  #  resources "/timeblocks", TimeblockController, except: [:new, :edit]
  # end
  scope "/ajax", Tasks2Web do
    pipe_through :ajax
    resources "/timeblocks", TimeblockController, except: [:new, :edit]
  end
end
