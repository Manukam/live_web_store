defmodule LiveWebStoreWeb.ProductController do
  use LiveWebStoreWeb, :controller
  alias Phoenix.LiveView
  alias LiveWebStore.Products

  def index(conn, params) do
    LiveView.Controller.live_render(conn, params)
  end

  def show(conn, %{"id" => sku}) do
    product = Products.get_product_by_sku(sku)
    render(conn, "show.html", product: product)
  end
end
