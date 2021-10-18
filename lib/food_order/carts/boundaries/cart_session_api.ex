defmodule FoodOrder.Carts.Boundaries.CartSessionApi do
  def get(user_id), do: GenServer.call(:cart_session, {:get, user_id})
  def update(user_id, product), do: GenServer.cast(:cart_session, {:put, user_id, product})
  def insert(user_id), do: GenServer.cast(:cart_session, {:insert, user_id})
end
