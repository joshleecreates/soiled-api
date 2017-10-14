defmodule SoiledApiWeb.Router do
  use SoiledApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SoiledApiWeb do
    pipe_through :api

    resources "/features", FeatureController, except: [:new, :edit]
  end
end
