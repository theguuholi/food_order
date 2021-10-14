defmodule FoodOrderWeb.Main.Components.FoodsComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrderWeb.Main.Components.Foods.ItemComponent

  def update(_, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  def item, do: ItemComponent
end
