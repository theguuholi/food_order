defmodule FoodOrderWeb.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrderWeb.ProductItemComponent

  def mount(_assign, _session, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  def product_item, do: ProductItemComponent
end
