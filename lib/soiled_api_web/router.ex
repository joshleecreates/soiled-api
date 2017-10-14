defmodule SoiledApiWeb.Router do
  use SoiledApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SoiledApiWeb do
    pipe_through :api

    resources "/soils", SoilController, only: [:index, :show]
    resources "/parcels", ParcelController, only: [:index, :show]
  end
end
