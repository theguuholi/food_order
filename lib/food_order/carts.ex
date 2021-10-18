defmodule FoodOrder.Carts do
  alias FoodOrder.Carts.Core.UpdateCart
  def update_cart(product, user) do
    UpdateCart.execute(product, user)
  end
end
