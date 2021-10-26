defmodule FoodOrder.Carts do
  alias FoodOrder.Carts.Boundaries.CartSessionApi

  def create_session(current_user_id), do: CartSessionApi.insert(current_user_id)
  def update_cart(product, current_user_id), do: CartSessionApi.update(current_user_id, product)
  def get_cart(current_user_id), do: CartSessionApi.get(current_user_id)
end
