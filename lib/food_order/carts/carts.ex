defmodule FoodOrder.Carts do
  alias FoodOrder.Carts.Boundaries.CartSessionApi

  def create_session(cart_id), do: CartSessionApi.insert(cart_id)
  def update_cart(product, cart_id), do: CartSessionApi.update(cart_id, product)
  def get_cart(cart_id), do: CartSessionApi.get(cart_id)
end
