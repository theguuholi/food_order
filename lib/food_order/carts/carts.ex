defmodule FoodOrder.Carts do
  alias FoodOrder.Carts.Boundaries.CartSessionApi

  def create_session(user_id), do: CartSessionApi.insert(user_id)
  def update_cart(product, user_id), do: CartSessionApi.update(user_id, product)
  def get_cart(user_id), do: CartSessionApi.get(user_id)
end
