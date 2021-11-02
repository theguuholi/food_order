defmodule FoodOrder.Carts do
  alias FoodOrder.Carts.Boundaries.CartSessionApi

  def create_session(cart_id), do: CartSessionApi.insert(cart_id)
  def add(product_id, cart_id), do: CartSessionApi.add(cart_id, product_id)
  def dec(product_id, cart_id), do: CartSessionApi.dec(cart_id, product_id)
  def remove(product_id, cart_id), do: CartSessionApi.remove(cart_id, product_id)
  def update_cart(product, cart_id), do: CartSessionApi.update(cart_id, product)
  def get_cart(cart_id), do: CartSessionApi.get(cart_id)
end
