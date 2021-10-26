defmodule FoodOrderWeb.Main.Components.FoodsComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrderWeb.Main.Components.Foods.ItemComponent

  def update(assigns, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products, current_user: assigns.current_user)}
  end

  def item, do: ItemComponent
end
