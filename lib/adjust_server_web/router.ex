defmodule AdjustServerWeb.Router do
  use AdjustServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AdjustServerWeb do
    pipe_through :api
  end

  scope "/dbs", AdjustServer do
    pipe_through :api
    get "/foo/tables/source", MainController, :get_source_foo
    get "/bar/tables/dest", MainController, :get_dest_bar
  end

end
